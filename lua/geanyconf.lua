-- geanyconf.lua
-- Script pour modifier le fichier de configuration de Geany
-- Usage : lua geanyconf.lua
local mygeanyconf = '/home/roland/.config/geany/geany.conf' -- à remplacer
local file = io.open(mygeanyconf, 'r')
local text = file:read('*a')
file:close()
-- Valeurs par défaut :
-- use_tab_to_indent=true
-- pref_editor_tab_width=4
-- indent_type=1
text = text:gsub('use_tab_to_indent=true', 'use_tab_to_indent=false')
text = text:gsub('pref_editor_tab_width=%d', 'pref_editor_tab_width=2')
text = text:gsub('indent_type=%d', 'indent_type=0')
file = io.open(mygeanyconf, 'w')
file:write(text)
file:close()
