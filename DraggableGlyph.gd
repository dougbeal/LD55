class_name DraggableGlyph
extends Area2D

var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO

@export
var symbol : GameLogic.Symbol:
	get:
		return _symbol
	set(value):
		if value != _symbol:
			_symbol = value
			if $Sprite2D != null:
				$Sprite2D.texture = _get_symbol_texture()
	
var _symbol : GameLogic.Symbol

const AIR_TEXTURE := preload("res://glyphs/air.svg")
const EARTH_TEXTURE := preload("res://glyphs/earth.svg")
const FIRE_TEXTURE := preload("res://glyphs/fire.svg")
const SALT_TEXTURE := preload("res://glyphs/salt.svg")
const WATER_TEXTURE := preload("res://glyphs/water.svg")

func _get_symbol_texture() -> Texture:
	match symbol:
		GameLogic.Symbol.AIR:
			return AIR_TEXTURE
		GameLogic.Symbol.EARTH:
			return EARTH_TEXTURE
		GameLogic.Symbol.FIRE:
			return FIRE_TEXTURE
		GameLogic.Symbol.SALT:
			return SALT_TEXTURE
		GameLogic.Symbol.WATER:
			return WATER_TEXTURE
		_:
			return SALT_TEXTURE

func _get_symbol_color() -> Color:
	match symbol:
		GameLogic.Symbol.EARTH:
			return Color.SADDLE_BROWN
		GameLogic.Symbol.AIR:
			return Color.DARK_TURQUOISE
		GameLogic.Symbol.FIRE:
			return Color.DARK_RED
		GameLogic.Symbol.WATER:
			return Color.AQUA
		GameLogic.Symbol.SALT:
			return Color.BEIGE
		_:
			return Color.LAWN_GREEN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = _get_symbol_texture()

func _draw() -> void:
	if $Sprite2D == null:
		draw_circle(Vector2.ZERO, 50, _get_symbol_color())
	
func begin_drag() -> void:
	is_dragging = true;
	drag_offset = get_global_mouse_position() - position
	
	
func end_drag() -> void:
	if is_dragging:
		is_dragging = false

func _on_input_event(_viewport : Viewport, event : InputEvent, _shape_idx : int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				begin_drag()
			else:
				end_drag()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_dragging:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			position = get_global_mouse_position() - drag_offset
	else:
		end_drag()