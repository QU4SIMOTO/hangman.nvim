local M = {}

---Pad with spaces and center align string to a specified width
---@param s string Input
---@param width integer The width of the line
---@return string
function M.pad_and_center(s, width)
  local free_space = width - #s
  if free_space <= 0 then
    return s
  end
  local offset = math.floor(free_space / 2)
  return string.rep(" ", offset) .. s
end

return M
