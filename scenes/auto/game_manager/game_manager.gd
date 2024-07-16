extends Node

signal sync_data(up)


var _data :Dictionary = {}
# var player_data :Dictionary = {} :
#     set(value): 
#         if not value.has('player'): return
#         if not value['player'] is Player: return
#         if not value.has('data'): return
#         if not value['data'] is Dictionary: return
#         for key in value['data'].keys():
#             player_data[key] = value['data'][key]
#     get: return player_data


func clear_connections () -> void:
    for connection in sync_data.get_connections():
        sync_data.disconnect(connection.callable)


func set_property (node_ :String, property_ :String, value_) -> void:
    if not _data.has(node_):
        _data[node_] = {}
    _data[node_][property_] = value_


func get_property (node_ :String, property_ :String)  -> Variant:
    if not _data.has(node_):
        return null
    if not _data[node_].has(property_):
        return null
    return _data[node_][property_]
