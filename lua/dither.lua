
--[[
  dither.lua
  
  https://legacy.imagemagick.org/Usage/quantize/#dither
  https://legacy.imagemagick.org/Usage/quantize/#colors
  https://legacy.imagemagick.org/Usage/bugs/ordered-dither/
  
  Dithering is turned on by default, to turn it off use the plus form of the setting, +dither.
  The color reduction operators -colors, -monochrome, -remap, and -posterize, apply dithering to images using the reduced color set they created.
  
  -colors value
  
  Set the preferred number of colors in the image.
  The actual number of colors in the image may be less than your request, but never more. Note that this a color reduction option.
  
  When converting an image from color to grayscale, it is more efficient to convert the image to the gray colorspace before reducing the number of colors.
  
  https://imagemagick.org/script/command-line-options.php#colors
--]]

local lDitherOption = {
  ['no'] = '+dither',
  ['fs'] = '-dither FloydSteinberg',
  ['rm'] = '-dither Riemersma'
}

function CmdLine(aSrcFile, aColors, aDither, aBaseName)
  local lOpt = lDitherOption[aDither]
  local lCmdFmt = string.format('magick %%s %s -colors %d %%s', lOpt, aColors)
  local lDstFile = string.format('%s-colors-%d-dither-%s.png', aBaseName, aColors, aDither)
  return lCmdFmt:format(aSrcFile, lDstFile)
end

local utils = require('sysutils')

if #arg >= 1 then
  local lSrcFile = arg[1]
  
  if utils.FileExists(lSrcFile) then
    local lBaseName = utils.ChangeFileExt(lSrcFile, '')
    print(type(arg[2]))
    --local lColors = ((#arg >= 2) and (type(arg[2]) == 'number')) and arg[2] or 64
    local lColors = ((#arg >= 2) and (tonumber(arg[2]) ~= nil)) and arg[2] or 64
    
    for k, v in pairs(lDitherOption) do
      local lCmdLine = CmdLine(lSrcFile, lColors, k, lBaseName)
      io.write('[DEBUG] lCmdLine "' .. lCmdLine .. '"\n')
      io.write('[DEBUG] os.execute ' .. (os.execute(lCmdLine) and '0' or '1'))
    end
  else
    io.write('[ERROR] File not found: "' .. lSrcFile .. '"\n')
  end
else
  io.write('Usage:\n  lua ' .. arg[0] .. ' FILE [NUMBER_OF_COLORS]\n  Default number of colors 64\n')
end
