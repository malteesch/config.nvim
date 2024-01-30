function P(...)
    vim.print(vim.inspect(...))
end

local GIT = {}
local STRING = {}

GIT.find_root = function()
    -- Use the current buffer's path as the starting point for the git search
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    -- If the buffer is not associated with a file, return nil
    if current_file == '' then
        current_dir = cwd
    else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
    end

    -- Find the Git root directory from the current file's path
    local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
    if vim.v.shell_error ~= 0 then
        print 'Not a git repository. Searching on current working directory'
        return cwd
    end
    return git_root
end

--- @param self string
--- @param other string
--- @return boolean
STRING.starts_with = function(self, other)
    return string.sub(self, 1, string.len(other)) == other
end

return {
    git = GIT,
    string = STRING
}
