vim.filetype.add {
    extension = {
        just = 'just',
    },
    filename = {
        ['.justfile'] = 'just',
        ['justfile'] = 'just',
        ['Justfile'] = 'just',
    },
}
