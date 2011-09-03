require 'rubygems'
require 'sinatra'
require 'haml'

get '/' do
  @title = 'Glitched TTF Generator'

  haml :index
end

put '/upload' do
  if params[:file]
    content_type params[:file][:type]
    attachment 'glitched_%i.ttf' % Time.now

    f = params[:file][:tempfile]
    data = f.read

    offset = glyph_offset(data)
    length = glyph_length(data)

    head = data[0, offset]
    glyphs = data[offset, length]
    other = data[offset + length .. -1]

    glyphs.gsub!(/\w/, '0')

    head + glyphs + other
  end
end

def glyph_offset(data)
  data[data.index('glyf') + 8, 4].unpack("N")[0]
end

def glyph_length(data)
  data[data.index('glyf') + 12, 4].unpack("N")[0]
end
