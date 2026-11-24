---@class MeetingStones
local MeetingStones = QuestieLoader:CreateModule("MeetingStones")
local _MeetingStones = {}

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

--- COMPATIBILITY ---
local strlower = string.lower

local function _NormalizeMeetingStoneName(name)
    if not name then
        return nil
    end

    return strlower(name)
end


---@param objectId number
---@return string?, string?
function MeetingStones:GetLocalizedDungeonNameAndLevelRangeByObjectId(objectId)
    local tableEntry = _MeetingStones.levelRanges[objectId]

    if (not tableEntry) then
        return nil, nil
    end

    return l10n(tableEntry.name), tableEntry.range
end

---@param dungeonName string
---@return string?
function MeetingStones:GetLevelRangeByDungeonName(dungeonName)
    if not dungeonName then
        return nil
    end

    if not _MeetingStones.levelRangesByName then
        _MeetingStones.levelRangesByName = {}

        for _, tableEntry in pairs(_MeetingStones.levelRanges) do
            _MeetingStones.levelRangesByName[_NormalizeMeetingStoneName(tableEntry.name)] = tableEntry.range
        end

        local supplementalRanges = {
            ["Zul'Gurub"] = "(60)",
            ["Onyxia's Lair"] = "(60)",
            ["Blackwing Lair"] = "(60)",
            ["Molten Core"] = "(60)",
            ["Ahn'Qiraj"] = "(60)",
            ["Ruins of Ahn'Qiraj"] = "(60)",
            ["Naxxramas"] = "(60)",
        }

        local aliases = {
            ["Temple of Ahn'Qiraj"] = "Ahn'Qiraj",
        }

        for instanceName, levelRange in pairs(supplementalRanges) do
            _MeetingStones.levelRangesByName[_NormalizeMeetingStoneName(instanceName)] = levelRange
        end

        for aliasName, sourceName in pairs(aliases) do
            local range = _MeetingStones.levelRangesByName[_NormalizeMeetingStoneName(sourceName)]
            if range then
                _MeetingStones.levelRangesByName[_NormalizeMeetingStoneName(aliasName)] = range
            end
        end
    end

    return _MeetingStones.levelRangesByName[_NormalizeMeetingStoneName(dungeonName)]
end

_MeetingStones.levelRanges = {
    [178824] = {
        name = "Razorfen Downs",
        range = "(33-41)"
    },
    [178825] = {
        name = "Razorfen Kraul",
        range = "(23-31)"
    },
    [178826] = {
        name = "Dire Maul",
        range = "(54-61)"
    },
    [178827] = {
        name = "Maraudon",
        range = "(40-52)"
    },
    [178828] = {
        name = "Blackfathom Deeps",
        range = "(20-28)"
    },
    [178829] = {
        name = "Zul'Farrak",
        range = "(42-50)"
    },
    [178831] = {
        name = "Stratholme",
        range = "(56-61)"
    },
    [178832] = {
        name = "Scholomance",
        range = "(56-61)"
    },
    [178833] = {
        name = "Uldaman",
        range = "(35-45)"
    },
    [178834] = {
        name = "The Deadmines",
        range = "(15-23)"
    },
    [178844] = {
        name = "Scarlet Monastery",
        range = "(30-44)"
    },
    [178845] = {
        name = "Shadowfang Keep",
        range = "(18-26)"
    },
    [178884] = {
        name = "Wailing Caverns",
        range = "(15-25)"
    },
    [179554] = {
        name = "The Temple of Atal'Hakkar",
        range = "(45-54)"
    },
    [179555] = {
        name = "Gnomeregan",
        range = "(24-34)"
    },
    [179584] = {
        name = "Blackrock Depths",
        range = "(48-60)"
    },
    [179585] = {
        name = "Blackrock Spire",
        range = "(53-61)"
    },
    [179595] = {
        name = "The Stockade",
        range = "(22-30)"
    },
    [179596] = {
        name = "Ragefire Chasm",
        range = "(13-18)"
    },
    [250633] = {
        name = "Baradin Hold",
        range = "(60)"
    },
    [250634] = {
        name = "Glittermurk Mines",
        range = "(35-43)"
    },
    [250635] = {
        name = "Uldum",
        range = "(60)"
    },
}
