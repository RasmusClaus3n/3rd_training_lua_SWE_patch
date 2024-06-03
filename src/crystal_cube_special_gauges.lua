-- SPECIAL GAUGES TRIGGER (KAITEN, DENJIN, ETC)

function bitReturn(value, bitnum)
    re = value
    re = SHIFT(re, bitnum - 31)
    re = SHIFT(re, 31)
    return re
end

function chargeGauge(str, x, y, address_charge, address_timer)
    gui.text(x - 20, y, str)
    if memory.readbyte(address_charge) ~= 0xFF then
        gui.drawbox(x, y, x + 42, y + assistHaba, 0x00000000, 0x000000FF)
        gui.drawbox(x, y, x + (memory.readbyte(address_charge)), y + assistHaba, 0x0080FFFF, 0x000000FF)
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

function kaitenGauge(str, x, y, address_juji, address_timer, timerOffset)
    gui.text(x - 24, y, str)
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
        chargeGauge("4-6K", offsetX, offsetY, 0x02025A49, 0x02025A47)
        offsetY = offsetY + offsetChargeGauge
        chargeGauge("2-8K", offsetX, offsetY, 0x02025A2D, 0x02025A2B)
        offsetY = offsetY + offsetChargeGauge
    end
    if kaitenView == 1 then
        if memory.readbyte(0x020154D3) == 0 then -- SA1 Hyper Bomb
            kaitenGauge("4268P", offsetX, offsetY, 0x0202590F, 0x020258F7, 20)
        end
    end
end

function hugoGauges()
    offsetX = 174
    offsetY = 160
    if kaitenView == 1 then
        kaitenGauge("4268P", offsetX, offsetY, 0x020259EF, 0x020259D7, 40)
        offsetY = offsetY + offsetKaitenGauge
        kaitenGauge("4268K", offsetX, offsetY, 0x02025A0B, 0x020259F3, 40)
        offsetY = offsetY + offsetKaitenGauge
        if memory.readbyte(0x020154D3) == 0 then
            juji_up = bitReturn(memory.readbyte(0x0202590F), 0);
            juji_down = bitReturn(memory.readbyte(0x0202590F), 1);
            juji_right = bitReturn(memory.readbyte(0x0202590F), 2);
            juji_left = bitReturn(memory.readbyte(0x0202590F), 3);
            x = offsetX
            y = offsetY
            gui.text(x - 46, y, "42684268P")
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
        if memory.readbyte(0x020154D3) == 2 then
            barColor = 0x00000000
            if dashiteruWaza == "S00280028"
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
            if memory.readbyte(0x02068D27) ~= 0 then
            end
        end
    end
end

function assistMode()
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

    -- Alex trigger
    if memory.readbyte(0x2011387) == 0x01 then
        alexGauges()
    end
    -- Ryu trigger
    if memory.readbyte(0x2011387) == 0x02 then
        ryuGauges()
    end

    -- ???
    if memory.readbyte(0x2011387) == 0x03 then
    end
    if memory.readbyte(0x2011387) == 0x04 then
    end
    if memory.readbyte(0x2011387) == 0x05 then
    end
    if memory.readbyte(0x2011387) == 0x07 then
    end
    if memory.readbyte(0x2011387) == 0x08 then
    end
    if memory.readbyte(0x2011387) == 0x0A then
    end
    if memory.readbyte(0x2011387) == 0x0B then
    end
    if memory.readbyte(0x2011387) == 0x0C then
    end
    --???

    -- Hugo trigger
    if memory.readbyte(0x2011387) == 0x06 then
        hugoGauges()
    end

    -- Charge Mode for ??? trigger
    if memory.readbyte(0x2011387) == 0x09 then
        offsetX = 180
        offsetY = 180
        if chargeView == 1 then
            chargeGauge("4-6P", offsetX, offsetY, 0x02025A11, 0x02025A0F)
            offsetY = offsetY + offsetChargeGauge
            chargeGauge("2-8P", offsetX, offsetY, 0x020259D9, 0x020259D7)
        end
    end

    -- Charge Mode for ??? trigger
    if memory.readbyte(0x2011387) == 0x0D then
        offsetX = 180
        offsetY = 180
        if chargeView == 1 then
            chargeGauge("4-6K", offsetX, offsetY, 0x020259D9, 0x020259D7)
            offsetY = offsetY + offsetChargeGauge
            chargeGauge("2-8P", offsetX, offsetY, 0x02025A2D, 0x02025A2B)
            offsetY = offsetY + offsetChargeGauge
            chargeGauge("2-8K", offsetX, offsetY, 0x020259F5, 0x020259F3)
        end
    end
    if memory.readbyte(0x2011387) == 0x0E then
    end
    if memory.readbyte(0x2011387) == 0x0F then
    end
    -- Lightning Legs Mode trigger
    if memory.readbyte(0x2011387) == 0x10 then
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
            chargeGauge("2-8K", offsetX, offsetY, 0x020259D9, 0x020259D7)
        end
    end
    if memory.readbyte(0x2011387) == 0x11 then
    end
    -- Charge Mode for ??? trigger
    if memory.readbyte(0x2011387) == 0x12 then
        offsetX = 180
        offsetY = 180
        if chargeView == 1 then
            chargeGauge("4-6P", offsetX, offsetY, 0x020259D9, 0x020259D7)
            offsetY = offsetY + offsetChargeGauge
            chargeGauge("4-6K", offsetX, offsetY, 0x020259F5, 0x020259F3)
        end
    end
    if memory.readbyte(0x2011387) == 0x13 then
    end
    -- Charge Mode for ??? trigger
    if memory.readbyte(0x2011387) == 0x14 then
        offsetX = 180
        offsetY = 180
        if chargeView == 1 then
            chargeGauge("4-6P", offsetX, offsetY, 0x020259F5, 0x020259F3)
            offsetY = offsetY + offsetChargeGauge
            chargeGauge("4-6K", offsetX, offsetY, 0x02025A11, 0x02025A0F)
            offsetY = offsetY + offsetChargeGauge
            chargeGauge("2-8K", offsetX, offsetY, 0x020259D9, 0x020259D7)
        end
    end
end
