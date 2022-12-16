function dirtree(dir)
  if string.sub(dir, -1) == "/" then
    dir=string.sub(dir, 1, -2)
  end

  local function yieldtree(dir)
    for entry in lfs.dir(dir) do
      if not entry:match("^%.") then
        entry=dir.."/"..entry
          if lfs.isdir(entry) then
            yieldtree(entry)
          else
            coroutine.yield(entry)
          end
      end
    end
  end

  return coroutine.wrap(function() yieldtree(dir) end)
end

--- Check if a file or directory exists in this path
function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

function openable(file)
   local ok, err, code = os.rename(file, file)
   return ok
end

--- Check if a directory exists in this path
function isdir(path)
   -- "/" works on both Unix and Windows
   return exists(path.."/")
end

function readlines(filename)
   local function yieldline(filename)
     local file = io.open(filename, "r")

      for line in string.split(file:read("*a"),"\n") do
	 coroutine.yield(line)
      end

      io.close(file)
  end

  return coroutine.wrap(function() yieldline(filename) end)
end

exercises = {}
flavor = {}
page_numbers = {}
section_numbers = {}
exercise_numbers = {}
references = {}
exercise_order = {}

for i in dirtree('./') do
   local filename = i

   if filename:match(".aux$") then
      for line in io.lines(filename) do
	 local c, _, m1, m2, m3, m4, m5 = string.find( line,
		"newlabel{([^}]*)}{{([0-9]*)}{([0-9]*)}{}{exercise.exercise.([0-9]*).([0-9]*)." )
	 if c then
	    section_numbers[m1] = m4 .. m5
	    exercise_numbers[m1] = m2
	    table.insert( exercise_order, m1 )
	 end

	 local c, _, m1, m2, m3 = string.find( line,
	       "newlabel{([^}]*)}{{([0-9]*)}{([0-9]*)}" )
	 if c then
	    page_numbers[m1] = m3
	    exercise_numbers[m1] = m2
	    table.insert( exercise_order, m1 )  
	 end

	 local c, _, m1, m2 = string.find( line,
	       "newlabel{([^}]*)}{({[0-9.]*}{[0-9.]*})" )
	 if c then
	    references[m1] = "{" .. m2 .. "}"
	 end
      end
   end
end

function table.clone(org)
  return {table.unpack(org)}
end

for i in dirtree('./') do
   local f = i

   if f:match(".tex$") then
      local depth = 0
      local solutioning = false
      local label = nil
      local output = {}
      
      local paragraph = {}
      local restart = false
      local preamble = true

      for line in io.lines(f) do
	 --line = string.gsub(line, "\\%.*", "")

	 if line:match("\\begin *{document}") then
	    preamble = false
	    goto continue 
         end

	 if preamble == true then
	    goto continue 
	 end

	 if line:match( "^[ ]*$" ) then
	    restart = true
	 end

         if line:match( "\\begin *{exercise}" ) or line:match( "\\begin *{computerExercise}" ) then
	    depth = depth + 1
	    output = {}
	 end

	 if depth == 0 and line:match( "[A-z]" ) then
	    if restart then
	       paragraph = {}
	       restart = false
	    end
      
	    table.insert( paragraph, line )
	 end
    
	 if line:match( "\\begin *{solution}" ) then
	    solutioning = true
	 end

	 if SOLUTIONS or (not solutioning) then
	    table.insert( output, line )
	 end
    
	 if depth > 0 then
	    local c, _, m1 = string.find( line, "\\label[ ]*{([^}]*)}" )
	    if c and label == nil then
	       label = m1
	       print("m.m.m.m" .. m1)
	       print(line)
	    end
	 end

	 if line:match( "\\end *{solution}" ) then
	    solutioning = false
	 end
    
	 if line:match( "\\end *{exercise}" ) or line:match( "\\end *{computerExercise}" ) then
	    depth = depth - 1

	    if depth == 0 then
	       --if not exercises[label].nil?
	       --puts "WARNING: in #{f} the exercise #{label} appears more than once."
	       --end
	       if label == nil then
		  print(filename)
	       else
		  exercises[label] = table.clone(output)
		  flavor[label] = table.clone(paragraph)
		  label = nil
	       end
	    end
	 end

	 ::continue::
      end
   end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

--tex.sprint( section_numbers )
--  table.sort(filenames)

 -- for i, v in pairs(filenames) do
 --   tex.sprint("\\subfile{" ..  dirname .. "/" .. v .. "}")
 -- end
--end


function insert_exercise(label)
   if exercises[label] == nil then
      tex.print("")
      tex.print("")
      tex.print("\\textbf{[MISSING " .. label .. "]}")
      tex.print("")
      tex.print("")
      return
   end

   if table.concat(exercises[label],"\n"):match('computerExercise') then
      tex.print("")
      tex.print("")
      tex.print("\\matlabproblemlabel")
      tex.print("")
      tex.print("")
   else
      tex.print("")
      tex.print("")
      tex.print("\\problemlabel")
      tex.print("")
      tex.print("")
   end
    
   --if $flavor and not flavors.include?( flavor[label] )
   --   text = flavor[label]
   --   unless already_flavored.any?{ |x| x == text }
   --     already_flavored << text
   --     line = line + text + "\n\n"
   --     flavors << text
   --   end
   -- end

   tex.print("")
   tex.print("")
   tex.print("\\exerciselabel{" .. exercise_numbers[label] .. "}{" .. section_numbers[label] .. "}")
   for i = 1, #exercises[label] do
      tex.print(exercises[label][i])
   end
   tex.print("")
   tex.print("")
end
