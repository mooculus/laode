mapping = {}
for line in File.open("./linearAlgebra.aux").readlines
  if line.match( /\\@writefile{toc}{\\contentsline {subsection}{([0-9]*.[0-9])*[^}]*}{[0-9]+}{section\*.([0-9]+)}}/ )
    mapping[$2] = $1
  end
end

sections = {}
for line in File.open("./linearAlgebra.aux").readlines
  if line.match( /\\newlabel{([^}]*)}{{([^}]*)}.*{section\*.([0-9]+)}{}}/ )
    section = mapping[$3]
    number = $2
    label = $1
    if section
      sections[label] = section
    end
  end
end

files = {}
for f in Dir.glob("./**/*.tex") do
  File.open(f).read.scan(/\\label{([^}]*)}/) { |r|
    r = r[0]
    if sections[r]
      files[sections[r]] = f
    end
  }
end

Dir.mkdir('by-number') unless File.exist?('by-number')
for k in files.keys
  File.symlink "../" + files[k], "./by-number/#{k}.tex"
  File.symlink "../" + files[k].gsub(/.tex/,''), "./by-number/#{k}"  
end
