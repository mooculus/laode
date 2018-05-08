for line in File.open("../linearAlgebra.aux").readlines
  if line.match( /\\newlabel{([^}]*)}{{([^}]*)}/ )
    number = $2
    label = $1
    if number.match( /\*$/ )
      matches = Dir.new('labeled').entries.select{ |x| x.match( Regexp.new( '^' + label + '\\.' ) ) }
      if matches.length != 1
        puts "missing #{number} #{label}"
      else
        mfile = matches.first
        number = number.gsub( '.', '_' ).gsub( /\*$/, '' )
        extension = mfile.split('.').last        
        `ln labeled/#{mfile} linearAlgebra/e#{number}.#{extension}`
      end
    end
  end
end
