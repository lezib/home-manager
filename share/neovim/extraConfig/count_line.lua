_G.count_strict_function_lines = function()
  local node = vim.treesitter.get_node()
  if not node then return end

  -- 1. Remonter jusqu'à la déclaration de la fonction
  while node do
    local type = node:type()
    if type:find("function") or type:find("method") then break end
    node = node:parent()
  end

  if not node then
    print("Aucune fonction trouvée")
    return
  end

  -- 2. Trouver le corps (block / compound_statement)
  local body_node = nil
  for child in node:iter_children() do
    local type = child:type()
    if type == "compound_statement" or type == "block" or type == "block_statement" then
      body_node = child
      break
    end
  end

  if not body_node then
    print("Corps de fonction non détecté")
    return
  end

  -- 3. Récupérer les lignes à l'intérieur du corps
  -- range() donne (start_row, start_col, end_row, end_col)
  local start_row, _, end_row, _ = body_node:range()

  -- On saute la ligne de l'accolade ouvrante (start_row + 1)
  -- On s'arrête avant la ligne de l'accolade fermante (end_row)
  local lines = vim.api.nvim_buf_get_lines(0, start_row + 1, end_row, false)

  -- 4. Préparer les filtres
  local count = 0
  -- Récupère le symbole de commentaire du fichier actuel (ex: // ou -- ou #)
  local cs = vim.bo.commentstring:gsub("%%s", ""):gsub("%-", "%%-"):gsub("%*", "%%*"):gsub("/", "%%/")
  local comment_pattern = "^%s*" .. cs

  for _, line in ipairs(lines) do
    -- On nettoie les espaces pour les vérifications
    local trimmed = line:gsub("%s+", "")

    -- CONDITIONS DE COMPTAGE :
    -- line:match("%S") -> La ligne n'est pas vide
    -- not line:match(comment_pattern) -> Ce n'est pas un commentaire
    -- trimmed ~= "{" and trimmed ~= "}" -> Ce n'est pas juste une accolade isolée
    -- trimmed ~= "{}" -> Cas particulier d'un bloc vide sur une ligne

    if line:match("%S") 
      and not line:match(comment_pattern) 
      and trimmed ~= "{" 
      and trimmed ~= "}" 
      and trimmed ~= "{}" then
      count = count + 1
    end
  end

  print("Lignes de code utiles : " .. count)
end
