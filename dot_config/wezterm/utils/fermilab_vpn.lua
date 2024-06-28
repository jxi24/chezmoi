M = {}

M.setup = function(config)

    config.launch_menu = {
        {
            label = "Wilson Cluster", args = {"ssh", "wc.fnal.gov"}, domain = {DomainName="local"},
        },
    }

end

return M
