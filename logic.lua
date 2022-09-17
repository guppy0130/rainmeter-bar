-- 0 stopped, 1 playing, 2 paused
-- so 1 = pause icon, 2 = play icon
musicIcons = {"", "", ""}
networkIcons = {"", "", "ﯩ", ""}
-- 10-100
batteryIcons = {"", "", "", "", "", "", "", "", "", ""}
-- charging, error, plugged
stateIcons = {"", "", "ﮣ"}

function Update()
    function SetText(meter, string)
        SKIN:Bang('!SetOption', meter, 'Text', string)
        SKIN:Bang('UpdateMeter', meter)
        SKIN:Bang('!Redraw')
    end

    function GetMeasure(name)
        return SKIN:GetMeasure(name)
    end

    function GetMeter(name)
        return SKIN:GetMeter(name)
    end

    function ByteCalc(size)
        i = 1
        while size >= 1024 do
            size = size / 1024
            i = i + 1
        end
        sizeDict = {"", "k", "m", "g", "t"}
        return string.format("%d%s", size, sizeDict[i])
    end

    function GetMedia()
        songIcon = musicIcons[GetMeasure('MeasurePlay'):GetValue() + 1]
        song = GetMeasure('MeasureTrack'):GetStringValue()
        return string.format("%s %s", songIcon, song)
    end

    function GetNetwork()
        connectivity = GetMeasure('MeasureConnected'):GetValue()
        if (connectivity == -1) then
            return "Unable to connect"
        end

        -- we are connected, so
        currNetworkIcon = ""
        currNetworkName = ""
        networkType = GetMeasure('MeasureAdapterType'):GetValue()

        -- set network icon
        if networkType == 71 then
            -- wifi
            currNetworkIcon = networkIcons[1]
            currNetworkName = GetMeasure('MeasureSSID'):GetStringValue()
        elseif networkType == 6 then
            -- ethernet
            currNetworkIcon = networkIcons[2]
            currNetworkName = "Ethernet"
        elseif networkType == 24 then
            -- loopback
            currNetworkIcon = networkIcons[3]
            currNetworkName = GetMeasure('MeasureHostName'):GetStringValue()
        elseif networkType == 53 then
            -- vpn?
            currNetworkIcon = networkIcons[4]
            currNetworkName = GetMeasure('MeasureHostName'):GetStringValue()
        end

        -- build final string
        return string.format("Rx: %s Tx: %s %s@%s %s",
        ByteCalc(GetMeasure("MeasureNetIn"):GetValue()),
        ByteCalc(GetMeasure("MeasureNetOut"):GetValue()),
        currNetworkName,
        GetMeasure('MeasureIP'):GetStringValue(),
        currNetworkIcon)
    end

    function GetPower()
        finalBatteryIcon = ""

        batteryState2 = GetMeasure('MeasurePluggedIn'):GetValue()
        batteryPercent = GetMeasure('MeasureBattery'):GetValue()

        if batteryState2 == 128 then
            -- no system battery
            return stateIcons[3]
        elseif batteryState2 == 255 then
            -- error
            return stateIcons[2]
        elseif batteryState2 == 8 then
            -- charging
            return stateIcons[1]
        elseif batteryPercent ~= nil then
            finalBatteryIcon = batteryIcons[math.floor(batteryPercent / 10) + 1]
            return string.format("%s %d", finalBatteryIcon, batteryPercent)
        else
            return "?"
        end

    end

    function SetRight()
        SetText("MeterRightText", string.format("%s %s", GetNetwork(), GetPower()))
    end

    function SetLeft()
        volume = "Muted"
        if GetMeasure("MeasureVolume"):GetValue() >= 0 then
            volume = string.format("Vol %d", GetMeasure("MeasureVolume"):GetValue())
        end

        SetText("MeterLeftText", string.format("%s | %s", GetMedia(), volume))
    end

    SetLeft()
    SetRight()
end
