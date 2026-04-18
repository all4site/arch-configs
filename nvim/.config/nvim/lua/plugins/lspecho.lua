return {
	"deathbeam/lspecho.nvim",
	config = function()
		require("lspecho").setup({
			echo = true, -- Echo progress messages, if set to false you can use .message() to get the current message
			decay = 3000, -- Message decay time in milliseconds
		})
	end,
}
