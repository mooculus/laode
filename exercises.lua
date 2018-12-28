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

local dirname = status.filename:gsub(".tex$","")

for i in dirtree(dirname) do
   local filename = i:gsub(".*/([^/]+)$","%1")
   
  tex.sprint("\\subfile{" ..  dirname .. "/" .. filename .. "}")
end
