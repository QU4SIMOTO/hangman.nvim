fmt:
	stylua lua/

lint:
	luacheck lua/ --globals vim

