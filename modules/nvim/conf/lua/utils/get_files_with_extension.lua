local M = {}
function M.scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

function M.get_directories(dir)
    local function traverse(current_dir)
        local dir_iter = vim.loop.fs_scandir(current_dir)
        if dir_iter then
            for entry in dir_iter do
                local name = entry.name
                local path = dir .. '/' .. name
                if entry.type == 'directory' then
                    coroutine.yield(path)
                    traverse(path)
                end
            end
        end
    end

    local co = coroutine.create(traverse)

    local function next_directory()
        local success, value = coroutine.resume(co, dir)
        if success then
            return value
        else
            error(value)
        end
    end

    local directories = {}
    local directory = next_directory()
    while directory do
        table.insert(directories, directory)
        directory = next_directory()
    end

    return directories
end

return M
