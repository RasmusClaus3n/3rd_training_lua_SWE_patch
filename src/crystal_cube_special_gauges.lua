-- Helper functions

function bitReturn(value, bitnum)
    re = value
    re = SHIFT(re, bitnum - 31)
    re = SHIFT(re, 31)
    return re
end

function returnSelectedCharacters()
    -- Relevant characters
    alex_is_selected = memory.readbyte(0x2011387) == 0x01
    chun_is_selected = memory.readbyte(0x2011387) == 0x10
    hugo_is_selected = memory.readbyte(0x2011387) == 0x06
    ryu_is_selected = memory.readbyte(0x2011387) == 0x02
    oro_is_selected = memory.readbyte(0x2011387) == 0x09
    q_is_selected = memory.readbyte(0x2011387) == 0x12
    remy_is_selected = memory.readbyte(0x2011387) == 0x14
    urien_is_selected = memory.readbyte(0x2011387) == 0x0D
    -- Irrelevant characters
    elena_is_selcted = memory.readbyte(0x2011387) == 0x08
    dudley_is_selected = memory.readbyte(0x2011387) == 0x04
    gouki_is_selected = memory.readbyte(0x2011387) == 0x0E
    ibuki_is_selected = memory.readbyte(0x2011387) == 0x07
    ken_is_selected = memory.readbyte(0x2011387) == 0x0B
    makoto_is_selected = memory.readbyte(0x2011387) == 0x11
    necro_is_selected = memory.readbyte(0x2011387) == 0x05
    sean_is_selected = memory.readbyte(0x2011387) == 0x0C
    shin_gouki_is_selected = memory.readbyte(0x2011387) == 0x0F
    twelve_is_selected = memory.readbyte(0x2011387) == 0x13
    yun_is_selected = memory.readbyte(0x2011387) == 0x03
    yang_is_selected = memory.readbyte(0x2011387) == 0x0A
end

function chargeGauge(str, x, y, charge_move, address_timer, x_adjust_left)
    if x_adjust_left == nil then
        gui.text(x - 20, y, str)
    else
        gui.text(x - x_adjust_left, y, str)
    end
    if memory.readbyte(charge_move) ~= 0xFF then
        gui.drawbox(x, y, x + 42, y + assistHaba, 0x00000000, 0x000000FF)
        gui.drawbox(x, y, x + (memory.readbyte(charge_move)), y + assistHaba, 0x0080FFFF, 0x000000FF)
    else
        gui.drawbox(x, y, x + 42, y + assistHaba, 0x00000000, 0xFEFEFEFF)
    end
    y = y + 3
    if memory.readbyte(address_timer) ~= 0xFF then
        gui.drawbox(x, y, x + 42, y + assistHaba, 0x00000000, 0x000000FF)
        gui.drawbox(x, y, x + (memory.readbyte(address_timer)), y + assistHaba, 0xFF8000FF, 0x000000FF)
    else
        gui.drawbox(x, y, x + 42, y + assistHaba, 0x00000000, 0x000000FF)
    end
end

function kaitenGauge(str, x, y, address_juji, address_timer, timerOffset, x_adjust_left)
    if x_adjust_left == nil then
        gui.text(x - 24, y, str)
    else
        gui.text(x - x_adjust_left, y, str)
    end
    juji_up = bitReturn(memory.readbyte(address_juji), 0)
    juji_down = bitReturn(memory.readbyte(address_juji), 1)
    juji_right = bitReturn(memory.readbyte(address_juji), 2)
    juji_left = bitReturn(memory.readbyte(address_juji), 3)
    jujiHaba = 6
    if juji_up == 1 then
        gui.text(x + jujiHaba, y - jujiHaba / 2, "8", 0xFF0000FF)
    else
        gui.text(x + jujiHaba, y - jujiHaba / 2, "8", 0xFFFFFFFF)
    end
    if juji_down == 1 then
        gui.text(x + jujiHaba, y + jujiHaba / 2, "2", 0xFF0000FF)
    else
        gui.text(x + jujiHaba, y + jujiHaba / 2, "2", 0xFFFFFFFF)
    end
    if juji_right == 1 then
        gui.text(x + jujiHaba * 2, y, "6", 0xFF0000FF)
    else
        gui.text(x + jujiHaba * 2, y, "6", 0xFFFFFFFF)
    end
    if juji_left == 1 then
        gui.text(x, y, "4", 0xFF0000FF)
    else
        gui.text(x, y, "4", 0xFFFFFFFF)
    end
    x = x + timerOffset
    gui.drawbox(x, y, x + 32, y + 4, 0x00000000, 0x000000FF)
    gui.drawbox(x, y, x + (memory.readbyte(address_timer)), y + 4, 0x00C080FF, 0x000000FF)
end

function numSpaceLeft(val, keta)
    temp = ""
    for i = 1, keta - #(val .. ""), 1 do
        temp = temp .. " "
    end
    temp = temp .. val
    return temp
end

-- Character specific functions

function alexGauges()
    offsetX = 180
    offsetY = 180
    if chargeView == 1 then
        chargeGauge("Elbow", offsetX, offsetY, 0x02025A49, 0x02025A47, 22)
        offsetY = offsetY + offsetChargeGauge
        chargeGauge("Stomp", offsetX, offsetY, 0x02025A2D, 0x02025A2B, 22)
        offsetY = offsetY + offsetChargeGauge
    end
    if kaitenView == 1 then
        if memory.readbyte(0x020154D3) == 0 then -- SA1 Hyper Bomb
            kaitenGauge("Hyper Bomb", offsetX, offsetY, 0x0202590F, 0x020258F7, 20, 45)
        end
    end
end

function chunGauges()
    offsetX = 170
    offsetY = 160
    if lightningLegsView == 1 then
        gui.text(offsetX, offsetY, "LK legs" .. " : " .. memory.readbyte(0x02025A03))
        offsetY = offsetY + offsetLightningLegsGauge
        gui.text(offsetX, offsetY, "MK legs" .. " : " .. memory.readbyte(0x02025A05))
        offsetY = offsetY + offsetLightningLegsGauge
        gui.text(offsetX, offsetY, "HK legs" .. " : " .. memory.readbyte(0x02025A07))
        offsetY = offsetY + offsetLightningLegsGauge
        gui.text(offsetX - 20, offsetY, "Legs")
        offsetY = offsetY + 1
        if memory.readbyte(0x02025A2D) ~= 0xFF then
            gui.drawbox(offsetX, offsetY, offsetX + 49, offsetY + lightningLegsWidth, 0x00000000, 0x000000FF)
            gui.drawbox(offsetX, offsetY, offsetX + ((memory.readbyte(0x020259f3) / 2)),
                offsetY + lightningLegsWidth,
                0xFF8080FF,
                0x000000FF)
        else
            gui.drawbox(offsetX, offsetY, offsetX + 49, offsetY + lightningLegsWidth, 0x00000000, 0xFEFEFEFF)
        end
        offsetY = offsetY + offsetLightningLegsGauge
    end
    if chargeView == 1 then
        chargeGauge("S.Bird", offsetX, offsetY, 0x020259D9, 0x020259D7, 28)
    end
end

function hugoGauges()
    offsetX = 174
    offsetY = 160
    if kaitenView == 1 then
        kaitenGauge("360+P", offsetX, offsetY, 0x020259EF, 0x020259D7, 40)
        offsetY = offsetY + offsetKaitenGauge
        kaitenGauge("360+K", offsetX, offsetY, 0x02025A0B, 0x020259F3, 40)
        offsetY = offsetY + offsetKaitenGauge
        if memory.readbyte(0x020154D3) == 0 then -- SA1 Gigas
            juji_up = bitReturn(memory.readbyte(0x0202590F), 0);
            juji_down = bitReturn(memory.readbyte(0x0202590F), 1);
            juji_right = bitReturn(memory.readbyte(0x0202590F), 2);
            juji_left = bitReturn(memory.readbyte(0x0202590F), 3);
            x = offsetX
            y = offsetY
            gui.text(x - 24, y, "Gigas")
            if memory.readbyte(0x020258FF) == 48 then
                jujiHaba = 6
                if juji_up == 1 then
                    gui.text(x + jujiHaba, y - jujiHaba / 2, "8", 0xFF0000FF)
                else
                    gui.text(x + jujiHaba, y - jujiHaba / 2, "8", 0xFFFFFFFF)
                end
                if juji_down == 1 then
                    gui.text(x + jujiHaba, y + jujiHaba / 2, "2", 0xFF0000FF)
                else
                    gui.text(x + jujiHaba, y + jujiHaba / 2, "2", 0xFFFFFFFF)
                end
                if juji_right == 1 then
                    gui.text(x + jujiHaba * 2, y, "6", 0xFF0000FF)
                else
                    gui.text(x + jujiHaba * 2, y, "6", 0xFFFFFFFF)
                end
                if juji_left == 1 then
                    gui.text(x, y, "4", 0xFF0000FF)
                else
                    gui.text(x, y, "4", 0xFFFFFFFF)
                end
                x = x + 20
                gui.text(x + jujiHaba, y - jujiHaba / 2, "8", 0xFFFFFFFF)
                gui.text(x + jujiHaba, y + jujiHaba / 2, "2", 0xFFFFFFFF)
                gui.text(x + jujiHaba * 2, y, "6", 0xFFFFFFFF)
                gui.text(x, y, "4", 0xFFFFFFFF)
            else
                jujiHaba = 6
                gui.text(x + jujiHaba, y - jujiHaba / 2, "8", 0xFF0000FF)
                gui.text(x + jujiHaba, y + jujiHaba / 2, "2", 0xFF0000FF)
                gui.text(x + jujiHaba * 2, y, "6", 0xFF0000FF)
                gui.text(x, y, "4", 0xFF0000FF)
                x = x + 20
                if juji_up == 1 then
                    gui.text(x + jujiHaba, y - jujiHaba / 2, "8", 0xFF0000FF)
                else
                    gui.text(x + jujiHaba, y - jujiHaba / 2, "8", 0xFFFFFFFF)
                end
                if juji_down == 1 then
                    gui.text(x + jujiHaba, y + jujiHaba / 2, "2", 0xFF0000FF)
                else
                    gui.text(x + jujiHaba, y + jujiHaba / 2, "2", 0xFFFFFFFF)
                end
                if juji_right == 1 then
                    gui.text(x + jujiHaba * 2, y, "6", 0xFF0000FF)
                else
                    gui.text(x + jujiHaba * 2, y, "6", 0xFFFFFFFF)
                end
                if juji_left == 1 then
                    gui.text(x, y, "4", 0xFF0000FF)
                else
                    gui.text(x, y, "4", 0xFFFFFFFF)
                end
            end
            x = x + 20
            gui.drawbox(x, y, x + 32, y + 4, 0x00000000, 0x000000FF)
            gui.drawbox(x, y, x + (memory.readbyte(0x020258F7)), y + 4, 0x00C080FF, 0x000000FF)
        end
    end
end

function ryuGauges()
    offsetX = 170
    offsetY = 190
    if denjinView == 1 then
        if memory.readbyte(0x020154D3) == 2 then -- SA3 Denjin is selected
            gui.text(50, 50, "Denjin?")
            barColor = 0x00000000
            if dashiteruWaza == "S00280028" -- Wtf is this
                or dashiteruWaza == "N0028000d"
                or dashiteruWaza == "N00280013"
                or dashiteruWaza == "N00280014"
                or dashiteruWaza == "N00280015"
                or dashiteruWaza == "N00280016"
                or dashiteruWaza == "N00280017"
                or dashiteruWaza == "S00290028"
                or dashiteruWaza == "N0029000d"
                or dashiteruWaza == "N00290013"
                or dashiteruWaza == "N00290014"
                or dashiteruWaza == "N00290015"
                or dashiteruWaza == "N00290016"
                or dashiteruWaza == "N00290017"
                or dashiteruWaza == "S002a0028"
                or dashiteruWaza == "N002a000d"
                or dashiteruWaza == "N002a0013"
                or dashiteruWaza == "N002a0014"
                or dashiteruWaza == "N002a0015"
                or dashiteruWaza == "N002a0016"
                or dashiteruWaza == "N002a0017"
            then
                denjinTimer = memory.readbyte(0x02068D27)
                denjin = memory.readbyte(0x02068D2D)
                if denjin == 3 then
                    denjinLv = 1
                    barColor = 0x0080FFFF
                elseif denjin == 9 then
                    denjinLv = 2
                    barColor = 0x00FFFFFF
                elseif denjin == 14 then
                    denjinLv = 3
                    barColor = 0x80FFFFFF
                elseif denjin == 19 then
                    denjinLv = 4
                    barColor = 0xFEFEFEFF
                    if denjinTimer == 0 then
                        denjinLv = 5
                    end
                end
            else
                if dashiteruWaza == "S00200020" or dashiteruWaza == "S00210021" or dashiteruWaza == "S00220022" or dashiteruWaza == "S00230023"
                    or dashiteruWaza == "S00340034" or dashiteruWaza == "S00350035" or dashiteruWaza == "S00360036" or dashiteruWaza == "S00370037"
                then

                else
                    denjinTimer = 0
                    memory.writebyte(0x02068D27, 0x00)
                    denjinLv = 0
                    memory.writebyte(0x02068D2D, 0x00)
                end
            end
            if dashiteruWaza == "N0028000d" or dashiteruWaza == "N0029000d" or dashiteruWaza == "N002a000d" then
            end
            gui.text(offsetX - 10, offsetY, numSpaceLeft(denjinTimer, 2))
            gui.text(offsetX - 38, offsetY, "LV_" .. denjinLv)
            offsetY = offsetY + 1
            gui.drawbox(offsetX, offsetY, offsetX + 8, offsetY + denjinHaba, 0x00000000, 0x000000FF)
            gui.drawbox(offsetX, offsetY, offsetX + 24, offsetY + denjinHaba, 0x00000000, 0x000000FF)
            gui.drawbox(offsetX, offsetY, offsetX + 48, offsetY + denjinHaba, 0x00000000, 0x000000FF)
            gui.drawbox(offsetX, offsetY, offsetX + 80, offsetY + denjinHaba, 0x00000000, 0x000000FF)
            gui.drawbox(offsetX, offsetY, offsetX + denjinTimer, offsetY + denjinHaba, barColor, 0x000000FF)
            if denjinTimer ~= 0 then
            end
        end
    end
end

function oroGauges()
    offsetX = 180
    offsetY = 180
    if chargeView == 1 then
        chargeGauge("Fireball", offsetX, offsetY, 0x02025A11, 0x02025A0F, 34)
        offsetY = offsetY + offsetChargeGauge
        chargeGauge("Oni Yanma", offsetX, offsetY, 0x020259D9, 0x020259D7, 38)
    end
end

function urienGauges()
    offsetX = 180
    offsetY = 180
    if chargeView == 1 then
        chargeGauge("Tackle", offsetX, offsetY, 0x020259D9, 0x020259D7, 35)
        offsetY = offsetY + offsetChargeGauge
        chargeGauge("Headbutt", offsetX, offsetY, 0x02025A2D, 0x02025A2B, 35)
        offsetY = offsetY + offsetChargeGauge
        chargeGauge("Kneedrop", offsetX, offsetY, 0x020259F5, 0x020259F3, 35)
    end
end

function qGauges()
    offsetX = 180
    offsetY = 180
    if chargeView == 1 then
        chargeGauge("Charge Punch", offsetX, offsetY, 0x020259D9, 0x020259D7, 50)
        offsetY = offsetY + offsetChargeGauge
        chargeGauge("Low Charge Punch", offsetX, offsetY, 0x020259F5, 0x020259F3, 66)
    end
end

function remyGauges()
    offsetX = 180
    offsetY = 180
    if chargeView == 1 then
        chargeGauge("S.Boom High", offsetX, offsetY, 0x020259F5, 0x020259F3, 47)
        offsetY = offsetY + offsetChargeGauge
        chargeGauge("S.Boom Low", offsetX, offsetY, 0x02025A11, 0x02025A0F, 44)
        offsetY = offsetY + offsetChargeGauge
        chargeGauge("Flashkick", offsetX, offsetY, 0x020259D9, 0x020259D7, 40)
    end
end

-- Main function

function assistMode()
    -- Determines what character is selected (P1)
    returnSelectedCharacters()

    -- Helper vars
    assistHaba = 2
    chargeView = 1
    kaitenView = 1
    lightningLegsView = 1
    denjinView = 1
    dashiteruWaza = "S00280028"
    denjinLv = 0
    denjinTimer = 0

    -- GUI vars
    offsetChargeGauge = 8
    offsetLightningLegsGauge = 8
    offsetKaitenGauge = 14
    denjinHaba = 4
    lightningLegsWidth = 4

    -- Relevant character is seleceted
    if alex_is_selected then
        alexGauges()
    end
    if ryu_is_selected then
        ryuGauges()
    end
    if hugo_is_selected then
        hugoGauges()
    end
    if chun_is_selected then
        chunGauges()
    end
    if oro_is_selected then
        oroGauges()
    end
    if urien_is_selected then
        urienGauges()
    end
    if q_is_selected then
        qGauges()
    end
    if remy_is_selected then
        remyGauges()
    end

    -- Irrelevant character is seleceted
    if
        elena_is_selected
        or dudley_is_selected
        or gouki_is_selected
        or ibuki_is_selected
        or ken_is_selected
        or makoto_is_selected
        or necro_is_selected
        or twelve_is_selected
        or sean_is_selected
        or shin_gouki_is_selected
        or yun_is_selected
        or yang_is_selected
    then
        -- Nohting happens!
    end
end
