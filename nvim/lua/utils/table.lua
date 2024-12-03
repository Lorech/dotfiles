local M = {}

-- Merges two Lua tables together into one.
--
-- @param t1 table: The first table to merge.
-- @param t2 table: The second table to merge.
-- @return table: The merged table.
M.merge = function(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

return M
