manual_inputs_path = "saved/manual inputs/"

function open_manual_input_popup()
    load_manual_input_popup.selected_index = 1
    menu_stack_push(load_manual_input_popup)

    load_file_index = 1

    local _cmd = "dir /b " .. string.gsub(manual_inputs_path, "/", "\\")
    local _f = io.popen(_cmd)
    if _f == nil then
        print(string.format("Error: Failed to execute command \"%s\"", _cmd))
        return
    end
    local _str = _f:read("*all")
    load_file_list = {}
    for _line in string.gmatch(_str, '([^\r\n]+)') do -- Split all lines that have ".json" in them
        if string.find(_line, ".json") ~= nil then
            local _file = _line
            table.insert(load_file_list, _file)
        end
    end
    load_manual_input_popup.content[1].list = load_file_list
end

load_manual_input_popup = make_menu(71, 61, 312, 122, -- screen size 383,223
    {
        list_menu_item("File", _G, "load_file_index", load_file_list),
        button_menu_item("Load", load_recording_slot_from_file),
        button_menu_item("Cancel", function() menu_stack_pop(load_manual_input_popup) end),
    })
