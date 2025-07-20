print("Setup mason.lua")

require("mason").setup({
    ui = {
        icons = {
            package_installed = "I",
            package_pending = "P",
            package_uninstalled = "U",
        },
    }
})
