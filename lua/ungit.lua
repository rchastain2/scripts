-- =============================================================================

-- ungit.lua

-- =============================================================================

function ReadText(AFileName)
  local f = io.open(AFileName, 'rb')
  if f ~= nil then
    local s = f:read('*all')
    f:close()
    return s
  else
    return nil
  end
end

function WriteText(AFileName, AText)
  local f = io.open(AFileName, 'w')
  f:write(AText)
  io.close(f)
end

-- =============================================================================

local GAction = false
local GRecurse = false

function RemoveDotGit(AProjectDir)
  io.write(string.format('[DEBUG] RemoveDotGit(%s)\n', AProjectDir))
  
  local filename = AProjectDir .. '/.git/config'
  local text = ReadText(filename)
  
  if text ~= nil then
    local url = string.match(text, 'url = (https://.-%.git)')
    
    if url ~= nil then
      io.write(string.format('[DEBUG] Repository URL: "%s"\n', url))
      -- Création du fichier url.txt
      filename = AProjectDir .. '/url.txt'
      io.write(string.format('[DEBUG] Create "%s"\n', filename))
      if GAction then
        WriteText(filename, url .. '\n')
      end
      -- Suppression du dossier .git
      filename = AProjectDir .. '/.git'
      io.write(string.format('[DEBUG] Remove "%s"\n', filename))
      if GAction then
        os.execute(string.format('rm -rf "%s"', filename))
      end
    else
      -- URL introuvable (peut-être un dépôt protégé par une clé SSH)
      io.write(string.format('[DEBUG] HTTP URL not found, exit (%s)\n', filename))
    end
  else
    -- Pas de fichier "config" à l'endroit attendu
    io.write(string.format('[DEBUG] Cannot read "%s"\n', filename))
  end
end

-- =============================================================================

function Shell(ACommand)
  local i, t, popen = 0, {}, io.popen
  for s in popen(ACommand):lines() do
    i = i + 1
    t[i] = s
  end
  return t
end

-- =============================================================================

function RecursiveRemoveDotGit(AStartDir)
  io.write(string.format('[DEBUG] RecursiveRemoveDotGit(%s)\n', AStartDir))
  local LFolders = Shell(string.format('find %s -type d -name ".git" 2> /dev/null', AStartDir))
  
  io.write(string.format('[DEBUG] Found %d .git folders\n', #LFolders))
  
  if #LFolders > 0 then
    table.sort(LFolders)
    for i = 1, #LFolders do
      RemoveDotGit(string.sub(LFolders[i], 1, -6))
    end
  end
end

-- =============================================================================

if #arg > 0 then
  local LDir = arg[1]
  
  if #arg > 1 then
    for i = 2, #arg do
      if arg[i] == '--action' then
        GAction = true
      elseif arg[i] == '--recurse' then
        GRecurse = true
      else
        io.write(string.format('[WARNING] Unrecognized option "%s"\n', arg[i]))
      end
    end
  end
  
  io.write(string.format('[INFO] Mode %s\n', GAction and 'ACTION' or 'SIMULATION'))
  
  if GRecurse then 
    RecursiveRemoveDotGit(LDir)
  else
    RemoveDotGit(LDir)
  end
else
  io.write('Usage:\n  lua ' .. arg[0] .. ' DIRECTORY [OPTIONS]\nOptions:\n  --action\n  --recurse\n')
end
