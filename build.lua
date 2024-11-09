local function build_zip(output)
    output = output or "build/untitled.love"
    os.execute("7z a " .. output .. " ./game/*")
end

build_zip()
