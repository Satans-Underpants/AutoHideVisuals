---------------------------------------------------------------------------------------------------------------------
--
--                      Contains UUIDs for Visuals
--
----------------------------------------------------------------------------------------------------------------------


-- Add to these Visuals when new ones are added.
-- Below you an find a python script for extracting them from the xml files



-- add your visual set slots uuids here 
-- these might be called ActiveSkeletonSlots

VISUAL_SET_SLOT = {

["101f3f89-a4e5-4e30-a0ff-7b5df0ccc30b"] = true, -- bodytype 1 - Fairy
["f1875d01-f363-4c93-9c47-099d8523d83b"] = true, -- bodytype 2 - Fairy
["e7693c9e-c0ef-4efc-aa81-b9eda147e47c"] = true, -- bodytype 3 - Fairy
["32bff1ce-f226-4c94-8b3d-598e13335e84"] = true -- bodytype 4 - Fairy

}


CHARACTER_CREATION_VISUALS = {

    ["040338f5-d0b8-4c59-88d0-fe2db0ff5e96"] = true, -- tiny wings bt1
    ["bfac7fda-325d-49da-938f-b231bc9e606f"] = true, -- butterfly wings bt1
    ["5b1546c0-1ce3-4bd2-a77a-e2ba2f9f3789"] = true, -- powdery wings bt1
    ["c66eab6b-ae40-4183-ab17-e0c7cba1fb12"] = true  -- see trough winds bt2

}







-- Python code to get all CCAVs

-- import xml.etree.ElementTree as ET


-- def extract_uuids(xml_string):
--     # Parse the XML string
--     root = ET.fromstring(xml_string)

--     # Find all 'attribute' elements with id 'UUID'
--     uuids = []
--     for attribute in root.findall(".//attribute[@id='UUID']"):
--         uuids.append(attribute.get('value'))

--     return uuids



-- xml_data = '''<?xml version="1.0" encoding="UTF-8"?>...........'''

-- uuids = extract_uuids(xml_data)
-- for uuid in uuids:
--     print(f'["{uuid}"] = true,')

