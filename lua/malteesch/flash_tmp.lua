local Flash = require("flash")

---@param opts Flash.Format
local function format(opts)
  -- always show first and second label
  return {
    { opts.match.label1, "FlashMatch" },
    { opts.match.label2, "FlashLabel" },
  }
end

Flash.jump({
  search = { mode = "search", max_length = 2 },
  label = { after = { 0, 2 } },
  ---@type fun(match:Flash.Match, state:Flash.State)|nil
  -- action = function (match, state)
  --   P(match)
  --   -- Flash.jump({
  --   --   search = { mode = "search", max_length = 1 },
  --   --   pattern = state.cache.pattern.search,
  --   --   label = { after = true },
  --   --   matcher = function (win, s, pos)
  --   --     P(s.cache.pattern.search)
  --   --     return {}
  --   --   end
  --   -- })
  -- end,
  ---@type fun(match:Flash.Match[], state:Flash.State)|nil
  labeler = function (matches, state)
    P(matches[1])
    if matches[1] ~= nil then
      matches[1].label = state:labels()[1]
    end
  end
})

-- Flash.jump({
--   search = { mode = "search" },
--   label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
--   pattern = [[\<]],
--   action = function(match, state)
--     state:hide()
--     Flash.jump({
--       search = { max_length = 0 },
--       highlight = { matches = false },
--       label = { format = format },
--       matcher = function(win)
--         -- limit matches to the current label
--         return vim.tbl_filter(function(m)
--           return m.label == match.label and m.win == win
--         end, state.results)
--       end,
--       labeler = function(matches)
--         for _, m in ipairs(matches) do
--           m.label = m.label2 -- use the second label
--         end
--       end,
--     })
--   end,
--   labeler = function(matches, state)
--     local labels = state:labels()
--     for m, match in ipairs(matches) do
--       match.label1 = labels[math.floor((m - 1) / #labels) + 1]
--       match.label2 = labels[(m - 1) % #labels + 1]
--       match.label = match.label1
--     end
--   end,
-- })
