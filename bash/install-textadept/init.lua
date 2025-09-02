
-- =============================================================================

-- Choix du thème et de la police pour la version GUI de Textadept.

if not CURSES then
  if os.getenv('USERNAME') then
    view:set_theme('base16-cupertino', {font = 'Courier', size = 12})
  else
    view:set_theme('base16-cupertino', {font = 'SourceCodePro', size = 12})
  end
end

-- https://github.com/rgieseke/base16-textadept
-- https://tinted-theming.github.io/tinted-gallery/

-- =============================================================================

-- Utiliser des espaces au lieu de tabulations, sauf dans les Makefile.

buffer.tab_width = 2

events.connect(events.LEXER_LOADED, function(name)
  buffer.use_tabs = name == 'makefile'
end)

-- =============================================================================

-- Utiliser FreeBASIC pour compiler les fichiers en Basic.

textadept.run.compile_commands.bas = 'fbc "%f"'

-- =============================================================================

-- Appliquer la coloration syntaxique Basic aux fichiers *.bi.

lexer.detect_extensions.bi = 'vb'

lexer.detect_extensions.lpr = 'pascal'
lexer.detect_extensions.pp = 'pascal'

-- https://github.com/orbitalquark/textadept/issues/626#issuecomment-3148499592

-- =============================================================================

-- Proposer la suppression de l'ancien fichier lorsque l'utilisateur sauvegarde
-- un fichier sous un nouveau nom.

local function save_as()
  local filename = buffer.filename
  if not buffer:save_as() then return end
  if not filename or filename == buffer.filename then return end

  local button = ui.dialogs.message
  {
    title = 'Delete file?', text = 'Would you like to delete ' .. filename .. '?',
    icon = 'dialog-question', button1 = 'Keep old file', button2 = 'Delete old file'
  }
  if button == 2 then os.remove(filename) end
end

textadept.menu.menubar['File/Save As'][2] = save_as
keys['ctrl+S'] = save_as

-- https://github.com/orbitalquark/textadept/issues/595

-- =============================================================================

-- Tracer une ligne verticale dans l'éditeur.

view.edge_mode = view.EDGE_LINE
view.edge_column = 80

-- =============================================================================

-- Utiliser le module Export.

--require('export')

-- https://github.com/orbitalquark/textadept-export

-- =============================================================================

-- Désactiver toutes les paires de caractères automatiques.

textadept.editing.auto_pairs = nil

-- =============================================================================

-- Supprimer automatiquement les blancs en fin de ligne.

--local function set_strip_trailing_spaces()
--	textadept.editing.strip_trailing_spaces = buffer.lexer_language ~= 'diff'
--end
--
--events.connect(events.LEXER_LOADED, set_strip_trailing_spaces)
--events.connect(events.BUFFER_AFTER_SWITCH, set_strip_trailing_spaces)
--events.connect(events.VIEW_AFTER_SWITCH, set_strip_trailing_spaces)

-- =============================================================================

-- Chercher le texte sélectionné (ou, à défaut, le mot situé à droite du curseur).

local function find_sel_text()
  if buffer.selection_empty then
    local s = buffer.current_pos
    local e = buffer:word_end_position(s, true)
    ui.find.find_entry_text = buffer:text_range(s, e)
  else
    ui.find.find_entry_text = buffer:get_sel_text()
  end
  ui.find.focus()
end

textadept.menu.menubar['Search/Find'][2] = find_sel_text
keys['ctrl+f'] = find_sel_text

-- https://github.com/orbitalquark/textadept/issues/603

-- =============================================================================

-- Update Notifier
-- https://github.com/orbitalquark/textadept-update-notifier

local update_notifier = require('update_notifier')

-- =============================================================================

-- https://github.com/orbitalquark/.textadept/blob/default/init.lua
-- https://orbitalquark.github.io/textadept/api.html
