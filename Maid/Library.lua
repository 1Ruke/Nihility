--// Nihility

--// UserData

--// Variables
local InputService = cloneref(UserSettings().GetService(game, 'UserInputService'));
local TweenService = cloneref(UserSettings().GetService(game, 'TweenService'));
local HttpService = cloneref(UserSettings().GetService(game, 'HttpService'));
local RunService = cloneref(UserSettings().GetService(game, 'RunService'));
local Workspace = cloneref(UserSettings().GetService(game, 'Workspace'));
local Lighting = cloneref(UserSettings().GetService(game, 'Lighting'));
local Players = cloneref(UserSettings().GetService(game, 'Players'));

--// Matrix
local NewVect2 = (Vector2.new);
local NewVect3 = (Vector3.new);

local NewAnglesCF = (CFrame.Angles);
local NewCF = (CFrame.new);

local Dim2 = (UDim2.new);
local NewDim = (UDim.new);
--]]

--// Colors
local FromRgb = (Color3.fromRGB);
local FromHex = (Color3.fromHex);
local FromHsv = (Color3.fromHSV)

local ColorKey = (ColorSequenceKeypoint.new);
local ColorSeq = (ColorSequence.new);

local NumKey = (NumberSequenceKeypoint.new);
local NumSeq = (NumberSequence.new);
--]]

--// Client
local Camera = cloneref(Workspace.CurrentCamera);
local Client = cloneref(Players.LocalPlayer);
local Center = (Camera.ViewportSize / 2);
--]]

local Mouse = cloneref(Client:GetMouse());
local GuiOffset = (cloneref(UserSettings().GetService(game, 'GuiService')):GetGuiInset().Y);

--// Math / Numbers
local Clamp = (math.clamp);
local Floor = (math.floor);
local Abs = (math.abs);
local Rad = (math.rad);
local Sin = (math.sin);
--]]

--// Table
local InsertTable = (table.insert);
local RemoveTable = (table.remove);
local ConcatTable = (table.concat);
local FindTable = (table.find);
--]]

--// String
local FormatString = (string.format);
local SubString = (string.sub);
--]]

--// Misc
local Setmetatable = clonefunction(setmetatable);
local Tostring = (tostring);
local Spawn = (task.spawn);
local Wait = (task.wait);
local Getfpscap = function() local Fps = getfpscap(); if Fps >= 0 then return 500 else return getfpscap() end; end;
--]]

--// Library init
	local Library = {
		Directory = 'Nihility';
		Folders = {'/Assets', '/Assets/Fonts', '/Assets/Images', '/Configs'};
		Flags = {};
		ConfigFlags = {};
		VisibleFlags = {};
		Guis = {};
		Connections = {};
		Notifications = {};
		PlayerlistData = {};
		Instances = {};
		Binds = {};
		CurrentTab;
		CurrentElementOpen;
		DockButtonHolder;
		OldConfig;
		Font;
		KeybindList;
		CopiedFlag;
		IsRainbow;
		Tick = tick();
		SelectedPlayer;
		DisplayOrder = 0;
		UTheme = 'Atlanta' --// Atlanta/Dracula
	};
	local Flags, ConfigFlags = Library.Flags, Library.ConfigFlags;

	local Themes = {
		Dracula = {
			['Outline'] = FromRgb(0, 0, 0);
			['Inline'] = FromRgb(60, 56, 77);
			['Accent'] = FromRgb(154, 129, 179);
			['LowContrast'] = FromRgb(26, 28, 37);
			['HighContrast'] = FromRgb(37, 39, 48);
			['Text'] = FromRgb(180, 180, 184);
			['TextOutline'] = FromRgb(32, 33, 38);
			['Glow'] = FromRgb(154, 129, 179);
		};
        
        Atlanta = {
            ["Outline"] = FromRgb(15, 2, 7),
            ["Inline"] = FromRgb(38, 9, 21),
            ["Accent"] = FromRgb(175, 50, 100),
            ["LowContrast"] = FromRgb(30, 6, 16),
            ["HighContrast"] = FromRgb(22, 4, 12),
            ["Text"] = FromRgb(136, 136, 136),
            ["TextOutline"] = FromRgb(0, 0, 0),
            ["Glow"] = FromRgb(0, 0, 0),
        };
        
		Utility = {
			['Outline'] = {
				['BackgroundColor3'] = {},
				['Color'] = {}, 
			},
			['Inline'] = {
				['BackgroundColor3'] = {},
			},
			['Accent'] = {
				['BackgroundColor3'] = {},
				['TextColor3'] = {}, 
				['ImageColor3'] = {}, 
				['ScrollBarImageColor3'] = {} 
			},
			['HighContrast'] = {
				['BackgroundColor3'] = {},
			},
			['LowContrast'] = {
				['BackgroundColor3'] = {},
			},
			['Contrast'] = {
				['Color'] = {},
			},
			['Text'] = {
				['TextColor3'] = {},
			},
			['TextOutline'] = {
				['Color'] = {},
			},
			['Glow'] = {
				['ImageColor3'] = {},
			}, 
		}, 
	};

	local Keys = {
		[Enum.KeyCode.LeftShift] = 'Ls',
		[Enum.KeyCode.RightShift] = 'Rs',
		[Enum.KeyCode.LeftControl] = 'Lc',
		[Enum.KeyCode.RightControl] = 'Rc',
		[Enum.KeyCode.Insert] = 'Ins',
		[Enum.KeyCode.Backspace] = 'Backsp',
		[Enum.KeyCode.Return] = 'Ent',
		[Enum.KeyCode.LeftAlt] = 'Lalt',
		[Enum.KeyCode.RightAlt] = 'Ralt',
		[Enum.KeyCode.CapsLock] = 'Caps',
		[Enum.KeyCode.One] = '1',
		[Enum.KeyCode.Two] = '2',
		[Enum.KeyCode.Three] = '3',
		[Enum.KeyCode.Four] = '4',
		[Enum.KeyCode.Five] = '5',
		[Enum.KeyCode.Six] = '6',
		[Enum.KeyCode.Seven] = '7',
		[Enum.KeyCode.Eight] = '8',
		[Enum.KeyCode.Nine] = '9',
		[Enum.KeyCode.Zero] = '0',
		[Enum.KeyCode.KeypadOne] = 'Num1',
		[Enum.KeyCode.KeypadTwo] = 'Num2',
		[Enum.KeyCode.KeypadThree] = 'Num3',
		[Enum.KeyCode.KeypadFour] = 'Num4',
		[Enum.KeyCode.KeypadFive] = 'Num5',
		[Enum.KeyCode.KeypadSix] = 'Num6',
		[Enum.KeyCode.KeypadSeven] = 'Num7',
		[Enum.KeyCode.KeypadEight] = 'Num8',
		[Enum.KeyCode.KeypadNine] = 'Num9',
		[Enum.KeyCode.KeypadZero] = 'Num0',
		[Enum.KeyCode.Minus] = '-',
		[Enum.KeyCode.Equals] = '=',
		[Enum.KeyCode.Tilde] = '~',
		[Enum.KeyCode.LeftBracket] = '[',
		[Enum.KeyCode.RightBracket] = ']',
		[Enum.KeyCode.RightParenthesis] = ')',
		[Enum.KeyCode.LeftParenthesis] = '(',
		[Enum.KeyCode.Semicolon] = ',',
		[Enum.KeyCode.Quote] = ' " ',
		[Enum.KeyCode.BackSlash] = '\\',
		[Enum.KeyCode.Comma] = ' , ',
		[Enum.KeyCode.Period] = '.',
		[Enum.KeyCode.Slash] = '/',
		[Enum.KeyCode.Asterisk] = '*',
		[Enum.KeyCode.Plus] = '+',
		[Enum.KeyCode.Period] = '.',
		[Enum.KeyCode.Backquote] = '`',
		[Enum.UserInputType.MouseButton1] = 'MB1',
		[Enum.UserInputType.MouseButton2] = 'MB2',
		[Enum.UserInputType.MouseButton3] = 'MB3',
		[Enum.KeyCode.Escape] = 'Esc',
		[Enum.KeyCode.Space] = 'Spc',
	};
		
	Library.__index = Library

	for _, Path in next, Library.Folders do 
		makefolder(Library.Directory .. Path)
	end;

	local Holder, ConfigHolder;
	if not Library then return end;

	--// Assets
	local HttpGet = clonefunction(game.HttpGet)
	if isfile(Library.Directory.. '/Assets/Fonts/HolderProggy.ttf') then delfile(Library.Directory.. '/Assets/Fonts/HolderProggy.ttf') end;
	if isfile(Library.Directory.. '/Assets/Fonts/Proggy.ttf') then delfile(Library.Directory.. '/Assets/Fonts/Proggy.ttf'); end;
	if isfile(Library.Directory.. '/Assets/Images/Glow.Png') then delfile(Library.Directory.. '/Assets/Images/Glow.Png'); end;
	if isfile(Library.Directory.. '/Assets/Images/Icon1.Png') then delfile(Library.Directory.. '/Assets/Images/Icon1.Png'); end;
	if isfile(Library.Directory.. '/Assets/Images/Icon2.Png') then delfile(Library.Directory.. '/Assets/Images/Icon2.Png'); end;
	if isfile(Library.Directory.. '/Assets/Images/Icon3.Png') then delfile(Library.Directory.. '/Assets/Images/Icon3.Png'); end;
	if isfile(Library.Directory.. '/Assets/Images/Icon4.Png') then delfile(Library.Directory.. '/Assets/Images/Icon4.Png'); end;
	if isfile(Library.Directory.. '/Assets/Images/Icon5.Png') then delfile(Library.Directory.. '/Assets/Images/Icon5.Png'); end;
	if isfile(Library.Directory.. '/Assets/Images/White.Png') then delfile(Library.Directory.. '/Assets/Images/White.Png'); end;

	writefile(Library.Directory.. '/Assets/Fonts/Proggy.ttf', HttpGet(game, 'https://github.com/1Ruke/Akira/raw/refs/heads/main/Assets/Fonts/ProggyClean.ttf'));
	writefile(Library.Directory.. '/Assets/Images/Glow.Png', HttpGet(game, 'https://raw.githubusercontent.com/1Ruke/Akira/refs/heads/main/Assets/Images/Glow.png'));
	writefile(Library.Directory.. '/Assets/Images/Icon1.Png', HttpGet(game, 'https://raw.githubusercontent.com/1Ruke/Akira/refs/heads/main/Assets/Images/Icon1.png'));
	writefile(Library.Directory.. '/Assets/Images/Icon2.Png', HttpGet(game, 'https://raw.githubusercontent.com/1Ruke/Akira/refs/heads/main/Assets/Images/Icon2.png'));
	writefile(Library.Directory.. '/Assets/Images/Icon3.Png', HttpGet(game, 'https://raw.githubusercontent.com/1Ruke/Akira/refs/heads/main/Assets/Images/Icon3.png'));
	writefile(Library.Directory.. '/Assets/Images/Icon4.Png', HttpGet(game, 'https://raw.githubusercontent.com/1Ruke/Akira/refs/heads/main/Assets/Images/Icon4.png'));
	writefile(Library.Directory.. '/Assets/Images/Icon5.Png', HttpGet(game, 'https://raw.githubusercontent.com/1Ruke/Akira/refs/heads/main/Assets/Images/Icon5.png'));
	writefile(Library.Directory.. '/Assets/Images/White.Png', HttpGet(game, 'https://raw.githubusercontent.com/1Ruke/Akira/refs/heads/main/Assets/Images/White.png'));

	if isfile(Library.Directory.. '/Assets/Fonts/Proggy.ttf') then Holder = {Name = 'Proggy', faces = {{Name = 'Regular', Weight = 400, Style = 'Normal', assetId = getcustomasset(Library.Directory.. '/Assets/Fonts/Proggy.ttf')}}}; end;
	writefile(Library.Directory.. '/Assets/Fonts/HolderProggy.ttf', HttpService:JSONEncode(Holder));
	Library.Font = Font.new(getcustomasset(Library.Directory.. '/Assets/Fonts/HolderProggy.ttf'), Enum.FontWeight.Regular);
	--]]

	--// Library Functions

	function Library:ApplyTheme(Obj, Theme, Property)
		if not (Obj or not Theme or not Property) then return end;
		InsertTable(Themes.Utility[Theme][Property], Obj)
	end;

	function Library:UpdateTheme(Theme, Color)
		if not (Themes.Utility[Theme]) then return end;
		for _, Property in next, Themes.Utility[Theme] do 
			for m, Object in next, Property do 
				if Object[_] == Themes[Library.UTheme][Theme] or Object.ClassName == 'UIGradient' then
					Object[_] = Color 
				end;
			end;
		end;
		Themes[Library.UTheme][Theme] = Color 
	end;

	--// Misc Functions
		function Library:Hover(Hover, Parent)
			if not (Hover or not Parent) then return end;
			local HoverInstance = Library:Create('Frame', {
				Parent = Parent,
				BackgroundTransparency = 1,
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Accent,
				ZIndex = 1;
			});
			Library:ApplyTheme(HoverInstance, 'Accent', 'BackgroundColor3')

			Hover.MouseEnter:Connect(function()
				Library:Tween(HoverInstance, {BackgroundTransparency = 0}, 0.185);
			end)
			
			Hover.MouseLeave:Connect(function()
				Library:Tween(HoverInstance, {BackgroundTransparency = 1}, 0.185);
			end)

			return HoverInstance;
		end;

		function Library:IsHovering(Object)
			if type(Object) == 'table' then
				local Pass = false;

				for _, Obj in Object do 
					if Library:IsHovering(Obj) then
						Pass = true
						return Pass
					end;
				end;
			else 
				local YCond, XCond = Object.AbsolutePosition.Y <= Mouse.Y and Mouse.Y <= Object.AbsolutePosition.Y + Object.AbsoluteSize.Y, Object.AbsolutePosition.X <= Mouse.X and Mouse.X <= Object.AbsolutePosition.X + Object.AbsoluteSize.X
				
				return (YCond and XCond)
			end;
		end;

		function Library:Resizeable(Frame)
			if not Frame then return end;
			local ResizePart = Instance.new('TextButton')
			ResizePart.Position = Dim2(1, -10, 1, -10)
			ResizePart.BorderColor3 = FromRgb(0, 0, 0)
			ResizePart.Size = Dim2(0, 10, 0, 10)
			ResizePart.BorderSizePixel = 0
			ResizePart.BackgroundColor3 = FromRgb(255, 255, 255)
			ResizePart.Parent = Frame
			ResizePart.BackgroundTransparency = 1
			ResizePart.Text = ''

			local Start, StartSize;
			local Resizing, OldSize = false, Frame.Size;

			ResizePart.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then
					Resizing = true
					Start = Input.Position
					StartSize = Frame.Size
				end;
			end)

			ResizePart.InputEnded:Connect(function(Input)
				if (Input.UserInputType == Enum.UserInputType.MouseButton1) then
					Resizing = false
				end;
			end)

			Library:Connection(InputService.InputChanged, function(Input, GameEvent)
				if (Resizing and Input.UserInputType == Enum.UserInputType.MouseMovement) then
					local CurrentSize = Dim2(StartSize.X.Scale, Clamp(StartSize.X.Offset + (Input.Position.X - Start.X), OldSize.X.Offset, Camera.ViewportSize.X), StartSize.Y.Scale, Clamp( StartSize.Y.Offset + (Input.Position.Y - Start.Y), OldSize.Y.Offset, Camera.ViewportSize.Y))
					Frame.Size = CurrentSize
				end;
			end)
		end;

		function Library:DragThing(Frame)
			local Dragging, StartSize = false, Frame.Position
			local Start

			Frame.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = true
					Start, StartSize = Input.Position, Frame.Position
			
					if Library.CurrentElementOpened then
						Library.CurrentElementOpened.SetVisible(false)
						Library.CurrentElementOpened.Open = false
						Library.CurrentElementOpened = nil
					end;

					if (Frame.Parent:IsA('GuiMain') and Frame.Parent.DisplayOrder ~= (2^31-1)) then
						Library.DisplayOrder += 1 --// shit code
						Frame.Parent.DisplayOrder = Library.DisplayOrder;
					elseif Frame.Parent.DisplayOrder < (2^31-1) then
						Library.DisplayOrder = 0
					end;
				end;
			end)

			Frame.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = false
				end;
			end)

			Library:Connection(InputService.InputChanged, function(Input, GameEvent)
				if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
					Frame.Position = Dim2(0, Clamp(StartSize.X.Offset + (Input.Position.X - Start.X), 0, Camera.ViewportSize.X - Frame.Size.X.Offset ), 0, Clamp(StartSize.Y.Offset + (Input.Position.Y - Start.Y), 0, Camera.ViewportSize.Y - Frame.Size.Y.Offset))
				end;
			end)
		end;
		
		function Library:Create(Class, Properties)
			local Inst = Instance.new(Class);
			for _, v in next, Properties do 
				Inst[_] = v
			end;

			InsertTable(Library.Instances, Inst)
			return Inst 
		end;

		function Library:ConvertEnum(enum)
			local EnumParts = {}
		
			for Part in clonefunction(string.gmatch)(enum, '[%w_]+') do
				InsertTable(EnumParts, Part)
			end;
		
			local EnumTable = Enum
			for i = 2, #EnumParts do
				local EnumItem = EnumTable[EnumParts[i]]
		
				EnumTable = EnumItem
			end;
		
			return EnumTable
		end;

		function Library:Tween(Obj, Properties, Time)
			local Tween = TweenService:Create(Obj, TweenInfo.new(Time, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0), Properties):Play()
			return Tween
		end;

		function Library:UpdateConfigList()
			if not ConfigHolder then return end;
		
			local List = {}
		
			for Idx, File in next, listfiles(Library.Directory .. '/Configs') do
				local Name = SubString(File:gsub(Library.Directory .. '/Configs\\', ''):gsub(Library.Directory .. '\\Configs\\', ''), 1, -5)
				List[#List + 1] = Name
			end;
			
			ConfigHolder.RefreshOptions(List)
		end;

		function Library:GetConfig()
			local Config = {};

			for Key, Value in Flags do
				if type(Value) == 'table' and Value.Key then
					Config[Key] = {Active = Value.Active, Mode = Value.Mode, Key = Tostring(Value.Key)};
				elseif type(Value) == 'table' and Value.Color then
					Config[Key] = {Color = Value.Color:ToHex()};
				else
					Config[Key] = Value;
				end;
			end;

			return HttpService:JSONEncode(Config);
		end;

		function Library:LoadConfig(ConfigJson)
			local Config = HttpService:JSONDecode(ConfigJson);

			for Key, Value in next, Config do 
				local FunctionSet = Library.ConfigFlags[Key];
				if FunctionSet then
					if type(Value) == 'table' and Value.Color then
						FunctionSet(FromHex(Value.Color));
					elseif type(Value) == 'table' and Value.Active then
						FunctionSet(Value);
					else
						FunctionSet(Value);
					end;
				end;
			end;
		end;

		function Library:Round(Number, Float)
			local Multiplier = 1 / (Float or 1)
			return Floor(Number * Multiplier + 0.5) / Multiplier
		end;

		function Library:Connection(Signal, Callback)
			local Connection = Signal:Connect(Callback)
			
			InsertTable(Library.Connections, Connection)

			return Connection 
		end;

		function Library:ApplyStroke(Parent)
			local Stroke = Library:Create('UIStroke', {
				Parent = Parent,
				Color = Themes[Library.UTheme].TextOutline, 
				LineJoinMode = Enum.LineJoinMode.Miter
			});
			
			Library:ApplyTheme(Stroke, 'TextOutline', 'Color')
		end;

		function Library:Create(Obj, Options)
			local Inst = Instance.new(Obj)
			
			for Prop, Value in next, Options do 
				Inst[Prop] = Value
			end;
			
			if Obj == 'TextLabel' or Obj == 'TextButton' or Obj == 'TextBox' then	
				Library:ApplyTheme(Inst, 'Text', 'TextColor3')
				Library:ApplyStroke(Inst)
			elseif Obj == 'GuiMain' then
				InsertTable(Library.Guis, Inst)
			end;
			
			return Inst 
		end;
		--// Lmfao
		local Elem = Library:Create('GuiMain', {Enabled = true, Parent = gethui(), Name = '', DisplayOrder = 1});
		local Elem2 = Library:Create('GuiMain', {Enabled = true, Parent = gethui(), Name = '', DisplayOrder = 1});
		local Elem3 = Library:Create('GuiMain', {Enabled = true, Parent = gethui(), Name = '', DisplayOrder = 1});
		local Elem4 = Library:Create('GuiMain', {Enabled = true, Parent = gethui(), Name = '', DisplayOrder = 1});
	--]]
	--// Elements
		function Library:Panel(Options)
			local Cfg = {
				Name = Options.Text or Options.Name or 'Window', 
				Size = Options.Size or Dim2(0, 530, 0, 590),
				Position = Options.Position or Dim2(0, 500, 0, 500),
				AnchorPoint = Options.AnchorPoint or NewVect2(0, 0),

				--// Button
				Image = Options.Image,
				Open = Options.Open or true,

				--// Ignore
				Items = {},
			};
			
			local Items = Cfg.Items do 
				--// Panel
				Items.SGui = Library:Create('GuiMain', {Enabled = true, Parent = gethui(), Name = ''});
					Items.MainHolder = Library:Create('Frame', {
						Parent = Items.SGui,
						-- Name = '',
						AnchorPoint = NewVect2(Cfg.AnchorPoint.X, Cfg.AnchorPoint.Y),
						Position = Cfg.Position,
						Active = true, 
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Cfg.Size,
						BorderSizePixel = 0,
						BackgroundColor3 = Themes[Library.UTheme].Outline
					});
					
					Library:DragThing(Items.MainHolder)
					Library:Resizeable(Items.MainHolder)

					local Close = Library:Create('TextButton' , {
						Parent = Items.MainHolder,
						FontFace = Library.Font,
						-- -- Name = '\0',
						AnchorPoint = NewVect2(1, 0),
						Active = false,
						BorderColor3 = FromRgb(0, 0, 0),
						Text = 'X',
						Size = Dim2(0, 0, 0, 0),
						Position = Dim2(1, -7, 0, 5),
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Right,
						AutomaticSize = Enum.AutomaticSize.XY,
						TextColor3 = Themes[Library.UTheme].Text,
						TextSize = 10,
						ZIndex = 100,
						BackgroundColor3 = FromRgb(255, 255, 255)
					});

					Library:Create('UIStroke' , {
						Parent = Close
					});
					
					Close.MouseButton1Click:Connect(function()
						Items.SGui.Enabled = false;
					end);

					Items.WindowInline = Library:Create('Frame', {
						Parent = Items.MainHolder,
						-- Name = '',
						Position = Dim2(0, 1, 0, 1),
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(1, -2, 1, -2),
						BorderSizePixel = 0,
						BackgroundColor3 = Themes[Library.UTheme].Accent
					});
					
					Library:ApplyTheme(Items.WindowInline, 'Accent', 'BackgroundColor3')
					
					Items.WindowHolder = Library:Create('Frame', {
						Parent = Items.WindowInline,
						-- Name = '',
						Position = Dim2(0, 1, 0, 1),
						BorderColor3 = Themes[Library.UTheme].Outline,
						Size = Dim2(1, -2, 1, -2),
						BorderSizePixel = 0,
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
								
					Items.UIGradient = Library:Create('UIGradient', {
						Parent = Items.WindowHolder,
						-- Name = '',
						Rotation = 90,
						Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
					});
		
					Library:ApplyTheme(Items.UIGradient, 'Contrast', 'Color')
					
					Items.Text = Library:Create('TextLabel', {
						Parent = Items.WindowHolder,
						-- Name = '',
						FontFace = Library.Font,
						TextColor3 = Themes[Library.UTheme].Accent,
						BorderColor3 = FromRgb(0, 0, 0),
						Text = Cfg.Name,
						BackgroundTransparency = 1,
						Position = Dim2(0, 2, 0, 4),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.XY,
						TextSize = 10;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					Library:ApplyTheme(Items.Text, 'Accent', 'TextColor3')
					
					Items.UIStroke = Library:Create('UIStroke', {
						Parent = Items.Text,
						-- Name = '',
						LineJoinMode = Enum.LineJoinMode.Miter
					});
					
					Items.UIPadding = Library:Create('UIPadding', {
						Parent = Items.WindowHolder,
						-- Name = '',
						PaddingBottom = NewDim(0, 4),
						PaddingRight = NewDim(0, 4),
						PaddingLeft = NewDim(0, 4)
					});
					
					Items.Outline = Library:Create('Frame', {
						Parent = Items.WindowHolder,
						-- Name = '',
						Position = Dim2(0, 0, 0, 18),
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(1, 0, 1, -18),
						BorderSizePixel = 0,
						BackgroundColor3 = Themes[Library.UTheme].Inline
					});
					
					Library:ApplyTheme(Items.Outline, 'Inline', 'BackgroundColor3')
					
					Items.Inline = Library:Create('Frame', {
						Parent = Items.Outline,
						-- Name = '',
						Position = Dim2(0, 1, 0, 1),
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(1, -2, 1, -2),
						BorderSizePixel = 0,
						BackgroundColor3 = Themes[Library.UTheme].Outline
					});
					
					Library:ApplyTheme(Items.Inline, 'Outline', 'BackgroundColor3')
					
					Items.Holder = Library:Create('Frame', {
						Parent = Items.Inline,
						-- Name = '',
						Position = Dim2(0, 1, 0, 1),
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(1, -2, 1, -2),
						BorderSizePixel = 0,
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					
					Items.UIGradient = Library:Create('UIGradient', {
						Parent = Items.Holder,
						-- Name = '',
						Rotation = 90,
						Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
					});
					
					Library:ApplyTheme(Items.UIGradient, 'Contrast', 'Color')
					
					Items.UIPadding = Library:Create('UIPadding', {
						Parent = Items.Holder,
						-- Name = '',
						PaddingTop = NewDim(0, 5),
						PaddingBottom = NewDim(0, 5),
						PaddingRight = NewDim(0, 5),
						PaddingLeft = NewDim(0, 5)
					});

					Items.Glow = Library:Create('ImageLabel', {
						Parent = Items.MainHolder,
						-- Name = '',
						ImageColor3 = Themes[Library.UTheme].Glow,
						ScaleType = Enum.ScaleType.Slice,
						BorderColor3 = FromRgb(0, 0, 0),
						BackgroundColor3 = FromRgb(255, 255, 255),
						Visible = true,
						Image = getcustomasset(Library.Directory.. '/Assets/Images/Glow.Png'),
						BackgroundTransparency = 1,
						ImageTransparency = 0.65, 
						Position = Dim2(0, -20, 0, -20),
						Size = Dim2(1, 40, 1, 40),
						ZIndex = 2,
						BorderSizePixel = 0,
						SliceCenter = Rect.new(NewVect2(21, 21), NewVect2(79, 79))
					});
					Library:ApplyTheme(Items.Glow, 'Glow', 'ImageColor3')
				--// 
				
				--// Button
					Items.Button = Library:Create('TextButton', {
						Parent = Library.DockHolder,
						-- Name = '',
						TextColor3 = FromRgb(0, 0, 0),
						BorderColor3 = FromRgb(0, 0, 0),
						Text = '',
						Size = Dim2(0, 25, 0, 25),
						BorderSizePixel = 0,
						TextSize = (10 + 3),
						BackgroundColor3 = Themes[Library.UTheme].Inline
					});
					
					local ButtonInline = Library:Create('Frame', {
						Parent = Items.Button,
						-- Name = '',
						Position = Dim2(0, 1, 0, 1),
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(1, -2, 1, -2),
						BorderSizePixel = 0,
						BackgroundColor3 = Themes[Library.UTheme].Outline
					});
					Library:ApplyTheme(ButtonInline, 'Outline', 'BackgroundColor3')
					
					local ButtonInline = Library:Create('Frame', {
						Parent = ButtonInline,
						-- Name = '',
						Position = Dim2(0, 1, 0, 1),
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(1, -2, 1, -2),
						BorderSizePixel = 0,
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					Library:ApplyTheme(ButtonInline, 'Inline', 'BackgroundColor3')
					
					local UIGradient = Library:Create('UIGradient', {
						Parent = ButtonInline,
						-- Name = '',
						Rotation = 90,
						Color = ColorSeq{ColorKey(0, FromRgb(35, 35, 47)), ColorKey(1, FromRgb(41, 41, 55))}
					});
					Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
					
					Items.Icon = Library:Create('ImageLabel', {
						Parent = ButtonInline,
						-- Name = '',
						ImageColor3 = Themes[Library.UTheme].Accent,
						Image = Cfg.Image,
						BackgroundTransparency = 1,
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(1, 0, 1, 0),
						BorderSizePixel = 0,
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					Library:ApplyTheme(Items.Icon, 'Accent', 'ImageColor3')
					
					local UIPadding = Library:Create('UIPadding', {
						Parent = ButtonInline,
						-- Name = '',
						PaddingTop = NewDim(0, 4),
						PaddingBottom = NewDim(0, 4),
						PaddingRight = NewDim(0, 4),
						PaddingLeft = NewDim(0, 4)
					});
			end;

			Items.SGui:GetPropertyChangedSignal('Enabled'):Connect(function()
				Items.Icon.ImageColor3 = Items.SGui.Enabled and Themes[Library.UTheme].Accent or Themes[Library.UTheme].Inline
			end)

			Items.Button.MouseButton1Click:Connect(function()
				Items.SGui.Enabled = not Items.SGui.Enabled
			end)
			
			return Setmetatable(Cfg, Library)
		end;

		local SGui = Library:Create('GuiMain', {Enabled = true, Parent = gethui(), Name = '', DisplayOrder = 999999 });

		local NotifHolder = Library:Create('GuiMain', {
			Parent = SGui,
			-- Name = '',
			IgnoreGuiInset = true,
			DisplayOrder = 999999, 
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		});

		function Library:FoldElements(Origin, Elements)
			for _, x in next, Elements do 
				local Flag = Library.VisibleFlags[x]

				if Flag then
					Flag(Flags[Origin])
				end;
			end;
		end;

		function Library:TargetIndicator()
			local Cfg = { Items = {} };
			local Items = Cfg.Items;
			do 
				Items.Window = Library:Create('Frame' , {
					Parent = Elem,
					-- Name = '\0',
					Position = Dim2(0, Center.X - 722, 0, 542),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 322, 0, 147),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline,
				});
				Library:DragThing(Items.Window);
				Library:ApplyTheme(Items.Window, 'Outline', 'BackgroundColor3');
				
				Items.InfoTitle = Library:Create('TextLabel' , {
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = 'Target Indicator',
					Parent = Items.Window,
					-- -- Name = '\0',
					Size = Dim2(1, 0, 0, 0),
					Position = Dim2(0, 7, 0, 5),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					ZIndex = 2,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextSize = 10,
				});

				Items.Accent = Library:Create('Frame' , {
					Parent = Items.Window,
					-- -- Name = '\0',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					ZIndex = 1,
					BackgroundColor3 = Themes[Library.UTheme].Accent,
				});	Library:ApplyTheme(Items.Accent, 'Accent', 'BackgroundColor3')

				Items.Background = Library:Create('Frame' , {
					Parent = Items.Accent,
					-- Name = '\0',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					ZIndex = 1,
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].LowContrast
				});
				Library:ApplyTheme(Items.Background, 'LowContrast', 'BackgroundColor3')
				
				Items.Inline = Library:Create('Frame' , {
					Parent = Items.Background,
					-- -- Name = '\0',
					Position = Dim2(0, 4, 0, 18),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -8, 1, -22),
					ZIndex = 1,
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Items.Inline, 'Outline', 'BackgroundColor3')
				
				Items.Outline = Library:Create('Frame' , {
					Parent = Items.Inline,
					-- -- Name = '\0',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					ZIndex = 1,
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Items.Outline, 'Inline', 'BackgroundColor3')
				
				Items.HighContrast = Library:Create('Frame' , {
					Parent = Items.Outline,
					-- -- Name = '\0',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					ZIndex = 1,
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].HighContrast
				});
				Library:ApplyTheme(Items.HighContrast, 'HighContrast', 'BackgroundColor3')
				
				Items.Inline = Library:Create('Frame' , {
					Parent = Items.HighContrast,
					-- -- Name = '\0',
					Position = Dim2(0, 4, 0, 4),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -8, 1, -8),
					ZIndex = 1,
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Items.Inline, 'Inline', 'BackgroundColor3')
				
				Items.Outline = Library:Create('Frame' , {
					Parent = Items.Inline,
					-- -- Name = '\0',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					ZIndex = 1,
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Items.Outline, 'Outline', 'BackgroundColor3')
				
				Items.HighContrast = Library:Create('Frame' , {
					Parent = Items.Outline,
					-- -- Name = '\0',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					ZIndex = 1,
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].HighContrast
				});
				Library:ApplyTheme(Items.HighContrast, 'HighContrast', 'BackgroundColor3');
				local ImageHolder = Items.HighContrast;
				
				Items.Inline = Library:Create('Frame' , {
					Parent = Items.HighContrast;
					-- Name = '\0';
					Position = Dim2(0, 4, 0, 4);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -8, 1, -8);
					ZIndex = 1;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Items.Inline, 'Inline', 'BackgroundColor3')
				
				Items.Outline = Library:Create('Frame' , {
					Parent = Items.Inline;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 1;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Items.Outline, 'Outline', 'BackgroundColor3')
				
				Items.HighContrast = Library:Create('Frame' , {
					Parent = Items.Outline;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 1;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].HighContrast
				});
				Library:ApplyTheme(Items.HighContrast, 'HighContrast', 'BackgroundColor3')

				Items.InfoTitle = Library:Create('TextLabel' , {
					FontFace = Library.Font;
					TextColor3 = Themes[Library.UTheme].Text;
					BorderColor3 = FromRgb(0, 0, 0);
					Text = 'Info';
					Parent = Items.Outline;
					-- Name = '\0';
					Size = Dim2(1, 0, 0, 0);
					Position = Dim2(0, 7, 0, 5);
					BackgroundTransparency = 1;
					TextXAlignment = Enum.TextXAlignment.Left;
					BorderSizePixel = 0;
					ZIndex = 2;
					AutomaticSize = Enum.AutomaticSize.Y;
					TextSize = 10;
				});

				Library:Create('UIStroke' , {
					Parent = Items.InfoTitle
				});
				
				Items.Accent = Library:Create('Frame' , {
					-- Name = '\0';
					Parent = Items.HighContrast;
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, 0, 0, 2);
					ZIndex = 1;
					BackgroundColor3 = Themes[Library.UTheme].Accent;
					BorderSizePixel = 0;
				});
				Library:ApplyTheme(Items.Accent, 'Accent', 'BackgroundColor3');
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Items.Accent,
					-- Name = '',
					Rotation = 180,
					Transparency = NumSeq{NumKey(0, 1), NumKey(0.4, 0.75), NumKey(1, 0)},
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(255, 255, 255))}
				});

				Items.Shadow = Library:Create('Frame' , {
					AnchorPoint = NewVect2(0, 1);
					Parent = Items.Accent;
					-- Name = '\0';
					Position = Dim2(0, 0, 1, 0);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, 0, 0, 1);
					ZIndex = 1;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Accent;
				});
				Library:ApplyTheme(Items.Shadow, 'Accent', 'BackgroundColor3');
				
				Library:Create('UIGradient' , {
					Rotation = 90;
					Parent = Items.Shadow;
					Color = ColorSeq{ColorKey(0, FromRgb(150, 150, 150)), ColorKey(1, FromRgb(150, 150, 150))}
				});
				
				Items.Holder = Library:Create('Frame' , {
					Parent = Items.HighContrast;
					-- Name = '\0';
					Position = Dim2(0, 76, 0, 21);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -80, 0, 0);
					ZIndex = 1;
					BorderSizePixel = 0;
				});	

				Library:Create('UIListLayout', {
					Parent = Items.Holder,
					Padding = NewDim(0, 4),
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder
				});

				Items.Inline = Library:Create('Frame' , {
					Parent = ImageHolder;
					-- Name = '\0';
					Position = Dim2(0, 10, 0, 28);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(0, 68, 0, 67);
					ZIndex = 1;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Items.Inline, 'Outline', 'BackgroundColor3')
				
				Items.Outline = Library:Create('Frame' , {
					Parent = Items.Inline;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 1;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Items.Outline, 'Inline', 'BackgroundColor3')
				
				Items.HighContrast = Library:Create('Frame' , {
					Parent = Items.Outline;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 1;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].HighContrast
				});
				Library:ApplyTheme(Items.HighContrast, 'HighContrast', 'BackgroundColor3')
				Items.Profile = Library:Create('ImageLabel' , {
					BorderColor3 = FromRgb(0, 0, 0);
					Parent = Items.HighContrast;
					Image = getcustomasset(Library.Directory.. '/Assets/Images/White.Png');
					BackgroundTransparency = 1;
					-- Name = '\0';
					Size = Dim2(1, 0, 1, 0);
					ZIndex = 2;
					BorderSizePixel = 0;
				});	

				local Section = Setmetatable(Items, Library)
				Items.Label = Section:Label({Name = 'Player: '});
				Items.Health = Section:Slider({Name = 'Health', Flag = '', Custom = FromRgb(25, 120, 0), Min = 0, Max = 100, Default = 100, InputDisabled = true});
				
				Library:Create('UIStroke' , {Parent = Items.InfoTitle});
			end;

			function Cfg.GetVisibility()
				return Items.Window.Visible
			end;

			function Cfg.SetVisible(Boolean)
				Items.Window.Visible = Boolean
			end;

			function Cfg.SetHealth(Value)
				Items.Health.Set(Value)
			end;

			function Cfg.ChangeProfile(Player)
				Items.Label.Set(FormatString('Player: %s', Player.Name)) -- Items.Label.Set(FormatString('Player: %s (%s)', Player.Name, Player.DisplayName))
				Items.Profile.Image = 'https://www.roblox.com/headshot-thumbnail/image?userId='.. Player.UserId ..'&width=420&height=420&format=png'
			end;

			return Setmetatable(Cfg, Library)
		end;

		function Library:InitEquipment()
			local Cfg = { Items = {}; }
			local Items = Cfg.Items; do
				Items.Window = Library:Create('Frame', {
					Parent = Elem2;
					-- Name = '\0';
					Position = Dim2(0, Center.X - 98, 0, 725);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(0, 304, 0, 100);
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:DragThing(Items.Window);
				Library:ApplyTheme(Items.Window, 'Outline', 'BackgroundColor3'); 

				Items.EquipmentTitle = Library:Create('TextLabel', {
					FontFace = Library.Font;
					TextColor3 = Themes[Library.UTheme].Text;
					BorderColor3 = FromRgb(0, 0, 0);
					Text = 'Equipment';
					Parent = Items.Window;
					-- Name = '\0';
					Size = Dim2(0, 1, 0, 1);
					ZIndex = 2;
					Position = Dim2(0, 5, 0, 5);
					BackgroundTransparency = 1;
					TextXAlignment = Enum.TextXAlignment.Left;
					BorderSizePixel = 0;
					ZIndex = 3;
					AutomaticSize = Enum.AutomaticSize.XY;
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255);
				});
				Library:ApplyTheme(Items.EquipmentTitle, 'Text', 'TextColor3');

				Items.Accent = Library:Create('Frame', {
					Parent = Items.Window;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 2;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Accent
				});
				Library:ApplyTheme(Items.Accent, 'Accent', 'BackgroundColor3')

				Items.Background = Library:Create('Frame', {
					Parent = Items.Accent;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 2;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].LowContrast
				});
				Library:ApplyTheme(Items.Background, 'LowContrast', 'BackgroundColor3')

				Items.Inline = Library:Create('Frame', {
					Parent = Items.Background;
					-- Name = '\0';
					Position = Dim2(0, 4, 0, 18);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -8, 1, -22);
					ZIndex = 2;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Items.Inline, 'Outline', 'BackgroundColor3')

				Items.Outline = Library:Create('Frame', {
					Parent = Items.Inline;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 2;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Items.Outline, 'Inline', 'BackgroundColor3')

				Items.HighContrast = Library:Create('Frame', {
					Parent = Items.Outline;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 2;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].HighContrast
				});
				Library:ApplyTheme(Items.HighContrast, 'HighContrast', 'BackgroundColor3')

				Items.Inline2 = Library:Create('Frame', {
					Parent = Items.HighContrast;
					-- Name = '\0';
					Position = Dim2(0, 4, 0, 4);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -8, 1, -8);
					ZIndex = 2;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Items.Inline2, 'Inline', 'BackgroundColor3')

				Items.Outline2 = Library:Create('Frame', {
					Parent = Items.Inline2;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 2;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Items.Outline2, 'Outline', 'BackgroundColor3')

				Items.HighContrast2 = Library:Create('Frame', {
					Parent = Items.Outline2;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 2;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].HighContrast
				});
				Library:ApplyTheme(Items.HighContrast2, 'HighContrast', 'BackgroundColor3')

				Items.ItemContainer = Library:Create('Frame', {
					Parent = Items.HighContrast2;
					-- Name = '\0';
					Position = Dim2(0, 0, 0, 0);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, 0, 1, 0);
					ZIndex = 2;
					BorderSizePixel = 0;
					BackgroundTransparency = 1;
					AutomaticSize = Enum.AutomaticSize.XY;
				});

				Items.ItemLayout = Library:Create('UIListLayout', {
					Parent = Items.ItemContainer;
					Padding = NewDim(0, 4);
					SortOrder = Enum.SortOrder.LayoutOrder;
					FillDirection = Enum.FillDirection.Horizontal;
				});

				Items.ItemPadding = Library:Create('UIPadding', {
					PaddingTop = NewDim(0, 5);
					PaddingLeft = NewDim(0, 5);
					Parent = Items.ItemContainer;
				});

				for i = 1, 5 do
					local ItemInline = Library:Create('Frame', {
						Name = 'ItemInline' .. i;
						Parent = Items.ItemContainer;
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(0, 50, 0, 50);
						ZIndex = 3;
						BorderSizePixel = 0;
						BackgroundColor3 = Themes[Library.UTheme].Outline;
						LayoutOrder = i;
					});
					Library:ApplyTheme(ItemInline, 'Outline', 'BackgroundColor3')

					local ItemOutline = Library:Create('Frame', {
						Parent = ItemInline;
						-- Name = '\0';
						Position = Dim2(0, 1, 0, 1);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, -2);
						BorderSizePixel = 0;
						BackgroundColor3 = Themes[Library.UTheme].Inline
					});
					Library:ApplyTheme(ItemOutline, 'Inline', 'BackgroundColor3')

					local Item0 = Library:Create('Frame', {
						Parent = ItemOutline;
						-- Name = '\0';
						Position = Dim2(0, 1, 0, 1);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, -2);
						ZIndex = 3;
						BorderSizePixel = 0;
						BackgroundColor3 = Themes[Library.UTheme].HighContrast
					});
					Library:ApplyTheme(Item0, 'HighContrast', 'BackgroundColor3')

					local ItemHighlight = Library:Create('UIGradient', {
						Parent = Item;
						-- Name = '';
						Rotation = 180;
						Transparency = NumSeq{NumKey(0, 1), NumKey(0.4, 0.75), NumKey(1, 0)};
						Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(255, 255, 255))};
					});

					local ItemStroke = Library:Create('UIStroke', {
						Color = Themes[Library.UTheme].Inline;
						Parent = Item;
					});

					-- Library:ApplyTheme(ItemStroke, 'Inline', 'Color')

					local ItemOutlineFrame = Library:Create('Frame', {
						BorderColor3 = FromRgb(0, 0, 0);
						AnchorPoint = NewVect2(0.5, 0.5);
						BackgroundTransparency = 1;
						Position = Dim2(0.5, 0, 0.5, 0);
						Name = 'Outline';
						Size = Dim2(0, 50, 0, 50);
						ZIndex = 3;
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(255, 255, 255);
						Parent = Item;
					});

					local ItemOutlineStroke = Library:Create('UIStroke', {
						Parent = ItemOutlineFrame;
					});

					local ItemGradient = Library:Create('UIGradient', {
						Rotation = 90;
						Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(95, 95, 95))};
						Parent = Item0;
					});

					Items['Item' .. i] = Item0;
				end;

				Library:Create('UIStroke', {
					Parent = Items.EquipmentTitle
				});
			end;

			function Cfg.GetVisibility()
				return Items.Window.Visible
			end;

			function Cfg.SetVisible(Boolean)
				Items.Window.Visible = Boolean
			end;

			function Cfg.GetItem(Index)
				return Items['Item' .. Index]
			end;

			function Cfg.AddItemToSlot(Index, ImageId)
				local Item = Items['Item' .. Index]
				if Item then
					local Img = Item:FindFirstChild('ItemImage')
					if Img then
						Img:Destroy()
					end;
			
					if ImageId then
						Library:Create('ImageLabel', {Name = 'ItemImage'; Parent = Item; BackgroundTransparency = 1; Size = Dim2(1, 0, 1, 0); ZIndex = 3; Image = 'rbxassetid://' .. ImageId; ScaleType = Enum.ScaleType.Fit});
					end;
				end;
			end;

			return Setmetatable(Cfg, Library)
		end;

		function Library:InitHotbar()
			local Cfg = { Items = {}; }
			local Items = Cfg.Items; do
				Items.Window = Library:Create('Frame', {
					Parent = Elem3;
					-- Name = '\0';
					--15
					Position = Dim2(0, Center.X + 510, 0, 561);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(0, 90, 0, 224);
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:DragThing(Items.Window);
				Library:ApplyTheme(Items.Window, 'Outline', 'BackgroundColor3');

				Items.HotbarTitle = Library:Create('TextLabel', {
					FontFace = Library.Font;
					TextColor3 = Themes[Library.UTheme].Text;
					BorderColor3 = FromRgb(0, 0, 0);
					Text = 'Hotbar';
					Parent = Items.Window;
					-- Name = '\0';
					Size = Dim2(1, 0, 0, 0);
					Position = Dim2(0, 7, 0, 5);
					BackgroundTransparency = 1;
					TextXAlignment = Enum.TextXAlignment.Left;
					BorderSizePixel = 0;
					ZIndex = 5;
					AutomaticSize = Enum.AutomaticSize.Y;
					TextSize = 10;
				});
				Library:ApplyTheme(Items.HotbarTitle, 'Text', 'TextColor3');

				Items.Accent = Library:Create('Frame', {
					Parent = Items.Window;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Accent
				});
				Library:ApplyTheme(Items.Accent, 'Accent', 'BackgroundColor3')

				Items.Background = Library:Create('Frame', {
					Parent = Items.Accent;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 4;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].LowContrast
				});
				Library:ApplyTheme(Items.Background, 'LowContrast', 'BackgroundColor3')

				Items.Inline = Library:Create('Frame', {
					Parent = Items.Background;
					-- Name = '\0';
					Position = Dim2(0, 4, 0, 18);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -8, 1, -22);
					ZIndex = 4;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Items.Inline, 'Outline', 'BackgroundColor3')

				Items.Outline = Library:Create('Frame', {
					Parent = Items.Inline;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 4;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Items.Outline, 'Inline', 'BackgroundColor3')

				Items.HighContrast = Library:Create('Frame', {
					Parent = Items.Outline;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 4;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].HighContrast
				});
				Library:ApplyTheme(Items.HighContrast, 'HighContrast', 'BackgroundColor3')

				Items.Inline2 = Library:Create('Frame', {
					Parent = Items.HighContrast;
					-- Name = '\0';
					Position = Dim2(0, 4, 0, 4);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -8, 1, -8);
					ZIndex = 4;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Items.Inline2, 'Inline', 'BackgroundColor3')

				Items.Outline2 = Library:Create('Frame', {
					Parent = Items.Inline2;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 4;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Items.Outline2, 'Outline', 'BackgroundColor3')

				Items.HighContrast2 = Library:Create('Frame', {
					Parent = Items.Outline2;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 4;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].HighContrast
				});
				Library:ApplyTheme(Items.HighContrast2, 'HighContrast', 'BackgroundColor3')

				Items.ItemContainer = Library:Create('Frame', {
					Parent = Items.HighContrast2;
					-- Name = '\0';
					Position = Dim2(0, 8, 0, 8);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -16, 1, -16);
					ZIndex = 4;
					BorderSizePixel = 0;
					BackgroundTransparency = 1;
				});

				Items.ItemLayout = Library:Create('UIListLayout', {
					Parent = Items.ItemContainer;
					Padding = NewDim(0, 8);
					HorizontalAlignment = Enum.HorizontalAlignment.Center;
					SortOrder = Enum.SortOrder.LayoutOrder;
				});

				for i = 1, 3 do
					local ItemInline = Library:Create('Frame', {
						Name = 'ItemInline' .. i;
						Parent = Items.ItemContainer;
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(0, 50, 0, 50);
						ZIndex = 4;
						BorderSizePixel = 0;
						BackgroundColor3 = Themes[Library.UTheme].Outline;
						LayoutOrder = i;
					});
					Library:ApplyTheme(ItemInline, 'Outline', 'BackgroundColor3')

					local ItemOutline = Library:Create('Frame', {
						Parent = ItemInline;
						-- Name = '\0';
						Position = Dim2(0, 1, 0, 1);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, -2);
						ZIndex = 4;
						BorderSizePixel = 0;
						BackgroundColor3 = Themes[Library.UTheme].HighContrast
					});
					Library:ApplyTheme(ItemOutline, 'Inline', 'BackgroundColor3')

					local Item0 = Library:Create('Frame', {
						Parent = ItemOutline;
						-- Name = '\0';
						Position = Dim2(0, 1, 0, 1);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, -2);
						ZIndex = 4;
						BorderSizePixel = 0;
						BackgroundColor3 = Themes[Library.UTheme].HighContrast
					});
					Library:ApplyTheme(Item0, 'HighContrast', 'BackgroundColor3')

					local ItemGradient = Library:Create('UIGradient', {
						Rotation = 90;
						Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(95, 95, 95))};
						Parent = Item0;
					});
					Items['Item' .. i] = Item0;
				end;

				Library:Create('UIStroke', {
					Parent = Items.HotbarTitle
				});
			end;

			function Cfg.GetVisibility()
				return Items.Window.Visible
			end;

			function Cfg.SetVisible(Boolean)
				Items.Window.Visible = Boolean
			end;

			function Cfg.GetItem(Index)
				return Items['Item' .. Index]
			end;

			function Cfg.AddItemToSlot(Index, ImageId)
				local Item = Items['Item' .. Index]
				if Item then
					local Img = Item:FindFirstChild('ItemImage')
					if Img then
						Img:Destroy()
					end;
			
					if ImageId then
						Library:Create('ImageLabel', {Name = 'ItemImage'; Parent = Item; BackgroundTransparency = 1; Size = Dim2(1, 0, 1, 0); ZIndex = 5; Image = 'rbxassetid://' .. ImageId; ScaleType = Enum.ScaleType.Fit});
					end;
				end;
			end;

			return Setmetatable(Cfg, Library)
		end;
		
		function Library:InitAmmo()
			local Cfg = {
				Items = {};
			};
			local Items = Cfg.Items; do
				Items.Window = Library:Create('Frame', {
					Parent = Elem4;
					-- Name = '\0';
					Position = Dim2(0, Center.X - 874, 0, 542);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(0, 150, 0, 50);
					ZIndex = Library.DisplayOrder;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:DragThing(Items.Window);
				Library:ApplyTheme(Items.Window, 'Outline', 'BackgroundColor3'); 	
				Items.AmmoTitle = Library:Create('TextLabel', {
					FontFace = Library.Font;
					TextColor3 = Themes[Library.UTheme].Text;
					BorderColor3 = FromRgb(0, 0, 0);
					Text = 'Ammo';
					Parent = Items.Window;
					-- Name = '\0';
					Size = Dim2(0, 1, 0, 1);
					ZIndex = 6;
					Position = Dim2(0, 10, 0, 6);
					BackgroundTransparency = 1;
					TextXAlignment = Enum.TextXAlignment.Left;
					BorderSizePixel = 0;
					ZIndex = 6;
					AutomaticSize = Enum.AutomaticSize.XY;
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255);
				});
				Library:ApplyTheme(Items.AmmoTitle, 'Text', 'TextColor3');

				Items.Accent = Library:Create('Frame', {
					Parent = Items.Window;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 5;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Accent
				});
				Library:ApplyTheme(Items.Accent, 'Accent', 'BackgroundColor3')

				Items.Background = Library:Create('Frame', {
					Parent = Items.Accent;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 5;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].LowContrast
				});
				Library:ApplyTheme(Items.Background, 'LowContrast', 'BackgroundColor3')

				Items.Inline = Library:Create('Frame', {
					Parent = Items.Background;
					-- Name = '\0';
					Position = Dim2(0, 4, 0, 18);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -8, 1, -22);
					ZIndex = 5;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Items.Inline, 'Outline', 'BackgroundColor3')

				Items.Outline = Library:Create('Frame', {
					Parent = Items.Inline;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 5;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Items.Outline, 'Inline', 'BackgroundColor3')

				Items.HighContrast = Library:Create('Frame', {
					Parent = Items.Outline;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 5;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].HighContrast
				});
				Library:ApplyTheme(Items.HighContrast, 'HighContrast', 'BackgroundColor3')

				Items.ProgressContainer = Library:Create('Frame', {
					Parent = Items.HighContrast;
					-- Name = '\0';
					AnchorPoint = NewVect2(0.5, 1);
					Position = Dim2(0.5, 0, 1, -2);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(0, 125, 0, 11);
					ZIndex = 5;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline;
				});
				Library:ApplyTheme(Items.ProgressContainer, 'Outline', 'BackgroundColor3')

				Items.ProgressContainerStroke = Library:Create('UIStroke', {Color = Themes[Library.UTheme].Inline; Parent = Items.ProgressContainer});
				
				Items.ProgressInline = Library:Create('Frame', {
					Parent = Items.ProgressContainer;
					-- Name = '\0';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 5;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Items.ProgressInline, 'Inline', 'BackgroundColor3')

				Items.ProgressBar = Library:Create('Frame', {
					Parent = Items.ProgressInline;
					Name = 'ProgressBar';
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					ZIndex = 5;
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Accent;
				});
				Library:ApplyTheme(Items.ProgressBar, 'Accent', 'BackgroundColor3');

				Items.ProgressBarStroke = Library:Create('UIStroke', {
					Parent = Items.ProgressBar;
				});

				Items.ProgressBarGradient = Library:Create('UIGradient', {
					Rotation = 180;
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(95, 95, 95))};
					Parent = Items.ProgressBar;
				}); 

				Items.AmmoValue = Library:Create('TextLabel', {
					FontFace = Library.Font;
					TextColor3 = Themes[Library.UTheme].Text;
					BorderColor3 = FromRgb(0, 0, 0);
					Text = '2/2';
					Name = 'Value';
					TextStrokeTransparency = 0;
					AnchorPoint = NewVect2(0.5, 0.5);
					Size = Dim2(0, 1, 0, 1);
					ZIndex = 6;
					BackgroundTransparency = 1;
					Position = Dim2(0.5, 0, 0.5, 0);
					BorderSizePixel = 0;
					AutomaticSize = Enum.AutomaticSize.XY;
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255);
					Parent = Items.ProgressBar;
				}); Library:ApplyTheme(Items.AmmoValue, 'Text', 'TextColor3');

				Library:Create('UIStroke', {
					Parent = Items.AmmoTitle
				});

				Library:Create('UIStroke', {
					Parent = Items.AmmoValue
				});
			end;

			function Cfg.GetVisibility()
				return Items.Window.Visible
			end;

			function Cfg.SetVisible(Boolean)
				Items.Window.Visible = Boolean
			end;

			function Cfg.SetAmmo(Current, Max)
				Items.AmmoValue.Text = Current .. '/' .. Max
				local Percentage = Max > 0 and Current / Max or 0
				Items.ProgressBar.Size = Dim2(Percentage, -2, 1, -2)
			end;

			function Cfg.SetAmmoText(Text)
				Items.AmmoValue.Text = Text
			end;

			function Cfg.SetProgress(Percentage)
				Percentage = Max(0, Floor(1, Percentage))
				Items.ProgressBar.Size = Dim2(Percentage, -2, 1, -2)
			end;

			function Cfg.SetProgressColor(Color)
				Items.ProgressBarGradient.Color = ColorSeq{ColorKey(0, Color), ColorKey(1, Color)}
			end;

			return Setmetatable(Cfg, Library)
		end;

		function Library:Watermark(Options) 
			local Cfg = {
				Default = Options.Text or Options.Default or os.os.date('Kira.xyz | %b %d %Y | %H:%M')
			}

			local WatermarkOutline = Library:Create('Frame', {
				Parent = SGui,
                Visible = false,
				-- Name = '',
				BorderColor3 = FromRgb(0, 0, 0),
				AnchorPoint = NewVect2(1, 1),
				Position = Dim2(0, Center.X + 200, 0, 0),
				Size = Dim2(0, 0, 0, 24),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundColor3 = Themes[Library.UTheme].Outline
			});

			Library:ApplyTheme(WatermarkOutline, 'Outline', 'BackgroundColor3');
			Library:DragThing(WatermarkOutline);
            Library.Watermark = WatermarkOutline;

			local NotificationInline = Library:Create('Frame', {
				Parent = WatermarkOutline,
				-- Name = '',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Inline
			});
			Library:ApplyTheme(NotificationInline, 'Inline', 'BackgroundColor3')
			
			local WatermarkBackground = Library:Create('Frame', {
				Parent = NotificationInline,
				-- Name = '',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			
			local UIGradient = Library:Create('UIGradient', {
				Parent = WatermarkBackground,
				-- Name = '',
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
			});
			Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
			
			local Text = Library:Create('TextLabel', {
				Parent = WatermarkBackground,
				-- Name = '',
				FontFace = Library.Font,
				TextColor3 = Themes[Library.UTheme].Text,
				BorderColor3 = FromRgb(0, 0, 0),
				Text = 'Kira.xyz',
				Size = Dim2(0, 0, 1, 0),
				BackgroundTransparency = 1,
				Position = Dim2(0, -1, 0, 1),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 10;
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			
			Library:Create('UIStroke', {
				Parent = Text,
				-- Name = '',
				LineJoinMode = Enum.LineJoinMode.Miter
			});
			
			local Accent = Library:Create('Frame', {
				Parent = WatermarkOutline,
				-- Name = '',
				Position = Dim2(0, 2, 0, 2),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -4, 0, 2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Accent
			});
			Library:ApplyTheme(Accent, 'Accent', 'BackgroundColor3')
			
			local UIGradient = Library:Create('UIGradient', {
				Parent = Accent,
				-- Name = '',
				Rotation = 180,
				Transparency = NumSeq{NumKey(0, 1), NumKey(0.4, 0.75), NumKey(1, 0)},
				Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(255, 255, 255))}
			});
			
			function Cfg.UpdateText(Input)
				Text.Text = '  '.. Input ..'  '
			end;
			return Cfg
		end;

		function Library:Window(Properties)
			local Window = {Opened = true};
			local Opened = {};
			local DockOutline;
			local Blur = Library:Create('BlurEffect' , {
				Parent = Lighting;
				Enabled = true;
				Size = 15
			});
			
			Library.Cache = Library:Create('GuiMain', {
				Enabled = false,
				Parent = gethui(),
				Name = '' 
			});

			function Window.SetMenuVisibility(Boolean)
				Window.Opened = Boolean 
				
				if Boolean then
					for _, Gui in Opened do 
						Gui.Enabled = true 
						Opened = {}
					end;
				else
					for _, Gui in Library.Guis do 
						if Gui.Enabled then
							Gui.Enabled = false
							InsertTable(Opened, Gui)
						end;
					end;
				end;

				Library:Tween(Blur, {Size = Boolean and (Flags['Blur Size']) or 0}, 0.185);
				DockOutline.Visible = Boolean;

				SGui.Enabled = true
				NotifHolder.Enabled = true
				Library.Cache.Enabled = false

				if Library.CurrentElementOpened then
					Library.CurrentElementOpened.SetVisible(false)
					Library.CurrentElementOpened.Open = false 
					Library.CurrentElementOpened = nil 
				end;
			end;

			--// Dock init
			DockOutline = Library:Create('Frame', {
				Parent = SGui,
				-- Name = '',
				Visible = true,
				BorderColor3 = FromRgb(0, 0, 0),
				AnchorPoint = NewVect2(0.5, 0),
				Position = Dim2(0.5, 0, 0, 20),
				Size = Dim2(0, 157, 0, 39),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Outline
			});

			Library:ApplyTheme(DockOutline, 'Outline', 'BackgroundColor3');
			DockOutline.Position = Dim2(0, DockOutline.AbsolutePosition.X, 0, DockOutline.AbsolutePosition.Y);
			DockOutline.AnchorPoint = NewVect2(0, 0);
			Library:DragThing(DockOutline);

			local DockInline = Library:Create('Frame', {
				Parent = DockOutline,
				-- Name = '',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Inline
			});
			Library:ApplyTheme(DockInline, 'Inline', 'BackgroundColor3')
			
			local DockHolder = Library:Create('Frame', {
				Parent = DockInline,
				-- Name = '',
				Size = Dim2(1, -2, 1, -2),
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = Themes[Library.UTheme].Outline,
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			Library:ApplyTheme(DockHolder, 'Outline', 'BackgroundColor3')
			
			local Accent = Library:Create('Frame', {
				Parent = DockHolder,
				-- Name = '',
				Size = Dim2(1, 0, 0, 2),
				BorderColor3 = FromRgb(0, 0, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Accent
			});
			Library:ApplyTheme(Accent, 'Accent', 'BackgroundColor3')
			
			local UIGradient = Library:Create('UIGradient', {
				Parent = Accent,
				-- Name = '',
				Rotation = 180,
				Transparency = NumSeq{NumKey(0, 1), NumKey(0.4, 0.75), NumKey(1, 0)},
				Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(255, 255, 255))}
			});
			
			local ButtonHolder = Library:Create('Frame', {
				Parent = DockHolder,
				-- Name = '',
				BackgroundTransparency = 1,
				Size = Dim2(1, 0, 1, 0),
				BorderColor3 = FromRgb(0, 0, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			}); Library.DockHolder = ButtonHolder;
			
			local UIListLayout = Library:Create('UIListLayout', {
				Parent = ButtonHolder,
				-- Name = '',
				Padding = NewDim(0, 5),
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder
			});
			
			local UIPadding = Library:Create('UIPadding', {
				Parent = ButtonHolder,
				-- Name = '',
				PaddingTop = NewDim(0, 6),
				PaddingBottom = NewDim(0, 4),
				PaddingRight = NewDim(0, 4),
				PaddingLeft = NewDim(0, 4)
			});
					
			local UIGradient = Library:Create('UIGradient', {
				Parent = DockHolder,
				-- Name = '',
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
			});
			Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
			--]]

			--// Keybind List
			local Outline = Library:Create('Frame', {
				Parent = SGui,
				-- Name = '',
				Visible = false, 
				Active = true,
				Draggable = true, 
				-- Position = Dim2(0, 0, 0, 200),
				Position = Dim2(0, Center.X - 906, 0, 594);
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(0, 182, 0, 25),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Outline
			});
			Library:ApplyTheme(Outline, 'Outline', 'BackgroundColor3');
			Library:DragThing(Outline);
			Library:Resizeable(Outline);
			Library.KeybindListFrame = Outline;
			
			local Inline = Library:Create('Frame', {
				Parent = Outline,
				-- Name = '',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Inline
			});
			Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')

			local Background = Library:Create('Frame', {
				Parent = Inline,
				-- Name = '',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			
			local UIGradient = Library:Create('UIGradient', {
				Parent = Background,
				-- Name = '',
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, Themes[Library.UTheme].LowContrast), ColorKey(1, Themes[Library.UTheme].HighContrast)}
			});
			Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
			
			local Bg = Library:Create('Frame', {
				Parent = Background,
				-- Name = '',
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, 0, 0, 2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Accent
			});
			Library:ApplyTheme(Bg, 'Accent', 'BackgroundColor3')

			Library:Create('UIGradient', {
				Parent = Bg,
				-- Name = '',
				Enabled = true, 
				Rotation = 180,
				Transparency = NumSeq{NumKey(0, 1), NumKey(0.4, 0.75), NumKey(1, 0)},
				Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(255, 255, 255))}
			});
			
			local Text = Library:Create('TextLabel', {
				Parent = Background,
				-- Name = '',
				FontFace = Library.Font,
				TextColor3 = Themes[Library.UTheme].Text,
				BorderColor3 = FromRgb(0, 0, 0),
				Text = 'Keybinds',
				BackgroundTransparency = 1,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Size = Dim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				TextSize = 10;
				BackgroundColor3 = Themes[Library.UTheme].Text
			}, 'Text')
			
			local UIStroke = Library:Create('UIStroke', {
				Parent = Text,
				-- Name = '',
				LineJoinMode = Enum.LineJoinMode.Miter
			});
			
			local TextHolder = Library:Create('Frame', {
				Parent = Background,
				-- Name = '',
				Position = Dim2(0, -2, 1, 1),
				Size = Dim2(1, 4, 0, 0),
				BorderColor3 = FromRgb(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Themes[Library.UTheme].Outline
			});
			Library:ApplyTheme(TextHolder, 'Outline', 'BackgroundColor3')

			local Inline = Library:Create('Frame', {
				Parent = TextHolder,
				-- Name = '',
				Size = Dim2(1, -2, 1, -2),
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				BorderSizePixel = 0,
				--AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Themes[Library.UTheme].Inline
			});
			Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')
			
			local Background = Library:Create('Frame', {
				Parent = Inline,
				-- Name = '',
				Size = Dim2(1, -2, 1, -2),
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				BorderSizePixel = 0,
				--AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			
			Library.KeybindList = Background
			
			local UIGradient = Library:Create('UIGradient', {
				Parent = Background,
				-- Name = '',
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, Themes[Library.UTheme].LowContrast), ColorKey(1, Themes[Library.UTheme].HighContrast)}
			});
			Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
			
			Library:Create('UIListLayout', {
				Parent = Background,
				-- Name = '',
				Padding = NewDim(0, -1),
				SortOrder = Enum.SortOrder.LayoutOrder
			});
			
			Library:Create('UIPadding', {
				Parent = Background,
				-- Name = '',
				PaddingBottom = NewDim(0, 4),
				PaddingLeft = NewDim(0, 5)
			});
			--]]

			--// Main Window
			local MainWindow = Library:Panel({
				Name = Properties and Properties.Name or 'Kira.xyz', 
				Size = Dim2(0, 604, 0, 628),
				Position = Dim2(0, (Camera.ViewportSize.X / 2) - 302 - 96, 0, (Camera.ViewportSize.Y / 2) - 421 - 12),
				Image = getcustomasset(Library.Directory.. '/Assets/Images/Icon1.Png'),
			});

			local Items = MainWindow.Items

			Window['TabHolder'] = Library:Create('Frame', {
				Parent = Items.Holder,
				-- Name = '';,
				BackgroundTransparency = 1,
				Size = Dim2(1, 0, 0, 22),
				BorderColor3 = FromRgb(0, 0, 0),
				ZIndex = 5,
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});

			Library:Create('UIListLayout', {
				Parent = Window['TabHolder'],
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = NewDim(0, 2),
				SortOrder = Enum.SortOrder.LayoutOrder
			});

			local SectionHolder = Library:Create('Frame', {
				Parent = Items.Holder,
				-- Name = '';,
				BackgroundTransparency = 1,
				Position = Dim2(0, -1, 0, 19),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, 0, 1, -22),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			Window['SectionHolder'] = SectionHolder

			local Outline = Library:Create('Frame', {
				Parent = SectionHolder,
				-- Name = '\0',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, 0, 1, 2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Outline
			});
			
			Library:ApplyTheme(Outline, 'Outline', 'BackgroundColor3')

			local Inline = Library:Create('Frame', {
				Parent = Outline,
				-- Name = '\0',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Inline
			});
			
			Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')

			local Background = Library:Create('Frame', {
				Parent = Inline,
				-- Name = '\0',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});

			Library.SectionHolder = Background

			Library:Create('UIPadding', {
				Parent = Background,
				PaddingTop = NewDim(0, 4),
				PaddingBottom = NewDim(0, 4),
				PaddingRight = NewDim(0, 4),
				PaddingLeft = NewDim(0, 4)
			});

			local UIGradient = Library:Create('UIGradient', {
				Parent = Background,
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
			});
			
			Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
			Library:Resizeable(Items.MainHolder) 
			--]]

			--// Theming 
			local Style = Library:Panel({
				Name = 'Style', 
				AnchorPoint = NewVect2(0, 0),
				Size = Dim2(0, 394, 0, 464),
				Position = Dim2(0, MainWindow.Items.MainHolder.AbsolutePosition.X + MainWindow.Items.MainHolder.AbsoluteSize.X + 2, 0, MainWindow.Items.MainHolder.AbsolutePosition.Y),
				Image = getcustomasset(Library.Directory.. '/Assets/Images/Icon2.Png'),
			});

			local Items = Style.Items
			local Column = Setmetatable(Items, Library):Column() 
			local Section = Column:Section({Name = 'Theme'});
			Section:Label({Name = 'Accent'}):Colorpicker({Name = 'Accent', Color = Themes[Library.UTheme].Accent, Flag = 'Accent', Callback = function(Color) Library:UpdateTheme('Accent', Color) end});
			Section:Label({Name = 'Contrast'}):Colorpicker({Name = 'High', Color = Themes[Library.UTheme].HighContrast, Flag = 'HighContrast', Callback = function(Color)
				if (Flags['LowContrast'] and Flags['HighContrast']) then
					Library:UpdateTheme('Contrast', ColorSeq{ColorKey(0, Flags['HighContrast'].Color), ColorKey(1, Flags['LowContrast'].Color)});
				end;
				Library:UpdateTheme('HighContrast', Flags['HighContrast'].Color) end;}):Colorpicker({Name = 'Low', Color = Themes[Library.UTheme].LowContrast, Flag = 'LowContrast', Callback = function(Color)
				Library:UpdateTheme('Contrast', ColorSeq{ColorKey(0, Flags['HighContrast'].Color), ColorKey(1, Flags['LowContrast'].Color)});
				Library:UpdateTheme('LowContrast', Flags['LowContrast'].Color)
			end});

			Section:Label({Name = 'Inline'}):Colorpicker({Name = 'Inline', Color = Themes[Library.UTheme].Inline, Callback = function(Color)
				Library:UpdateTheme('Inline', Color)
			end; Flag = 'Inline'});

			Section:Label({Name = 'Outline'}):Colorpicker({Name = 'Outline', Color = Themes[Library.UTheme].Outline, Callback = function(Color)
				Library:UpdateTheme('Outline', Color)
			end; Flag = 'Outline'});

			Section:Label({Name = 'Text Color'}):Colorpicker({Name = 'Main', Color = Themes[Library.UTheme].Text, Callback = function(Color)
				Library:UpdateTheme('Text', Color)
			end; Flag = 'Main'}):Colorpicker({Name = 'Outline', Color = Themes[Library.UTheme].TextOutline, Callback = function(Color)
				Library:UpdateTheme('TextOutline', Color)
			end; Flag = 'Outline'});

			Section:Label({Name = 'Glow'}):Colorpicker({Name = 'Glow', Color = Themes[Library.UTheme].Glow, Callback = function(Color)
				Library:UpdateTheme('Glow', Color)
			end; Flag = 'Glow'});

			Section:Slider({Name = 'Blur Size', Flag = 'Blur Size', Min = 1, Max = 56, Default = 30, Interval = 0.5, Callback = function(Value)
				if Window.Opened then
					Blur.Size = Value
				end;
			end});

			local Section = Column:Section({Name = 'Other'});
			Section:Label({Name = 'UI Bind'}):Keybind({Flag = 'Menu Bind', Key = Enum.KeyCode.End, Callback = Window.SetMenuVisibility});
			Section:Toggle({Name = 'Keybind List', Default = false, Flag = 'Menu KeybindList', Callback = function(Bool) Library.KeybindListFrame.Visible = (Bool) end});
			Section:Toggle({Name = 'Watermark', Default = false, Flag = 'Menu Watermark', Callback = function(Bool) pcall(function() Library.Watermark.Visible = Bool end); end}); --// Gay ass pcall </3
			Section:Toggle({Name = 'Spin Esp Preview', Flag = 'Menu Spin Preview', Default = false});
			Section:Slider({Name = 'Fps Cap', Flag = 'Menu Fps Cap', Min = 30, Max = 500, Default = getfpscap(), Interval = 1, Callback = function(Value) setfpscap(Value) end});
			Section:ButtonHolder({});
			Section:Button({Name = 'Rejoin', Callback = function()
				cloneref(game:GetService('TeleportService')):TeleportToPlaceInstance(game.PlaceId, game.JobId, Client);
			end});
			--]]

			--// Cfg Holder
			local Holder = Library:Panel({
				Name = 'Configurations', 
				Size = Dim2(0, 324, 0, 410),
				Position = Dim2(0, Items.MainHolder.AbsolutePosition.X + Items.MainHolder.AbsoluteSize.X + 2, 0, Items.MainHolder.AbsolutePosition.Y),
				Image = getcustomasset(Library.Directory.. '/Assets/Images/Icon3.Png'),
			}); 

			local Items = Holder.Items
			local Column = Setmetatable(Items, Library):Column()
			local Section = Column:Section({Name = 'Options'});
				ConfigHolder = Section:List({Flag = 'ConfigNameList'});
				Section:Textbox({Flag = 'ConfigNameTextBox'});
				Section:ButtonHolder({});
				Section:Button({Name = 'Create', Callback = function()
					writefile(Library.Directory .. '/Configs/' .. Flags['ConfigNameTextBox'] .. '.Cfg', Library:GetConfig())
					Library:UpdateConfigList()
				end});
				Section:Button({Name = 'Delete', Callback = function()
					if (Flags['ConfigNameList']) ~= nil then
						delfile(Library.Directory .. '/Configs/' .. Flags['ConfigNameList'] .. '.Cfg')
						Library:UpdateConfigList()
					else
						Library:Notification({Text = 'Config not found', Time = 3});
					end;
				end});
				Section:ButtonHolder({});
				Section:Button({Name = 'Load', Callback = function()
					if (Flags['ConfigNameList']) ~= nil then
						Library:LoadConfig(readfile(Library.Directory .. '/Configs/' .. Flags['ConfigNameList'] .. '.Cfg'))
						Library:Notification({Text = 'Loaded Config: ' .. Flags['ConfigNameList'], Time = 3});
					else
						Library:Notification({Text = 'Config not found', Time = 3});
					end;
				end});
				Section:Button({Name = 'Save', Callback = function()
					if (Flags['ConfigNameList']) ~= nil then
						writefile(Library.Directory .. '/Configs/' .. Flags['ConfigNameList'] .. '.Cfg', Library:GetConfig())
						Library:UpdateConfigList()
						Library:Notification({Text = 'Saved Config: ' .. Flags['ConfigNameList'], Time = 3});
					else
						Library:Notification({Text = 'Config requires a name', Time = 3});
					end;
				end});
				Section:ButtonHolder({});
				Section:Button({Name = 'Refresh Configs', Callback = function()
					Library:UpdateConfigList()
				end});
				Section:ButtonHolder({});
				Section:Button({Name = 'Unload Config', Callback = function()
					Library:LoadConfig(Library.OldConfig)
				end});
				Section:Button({Name = 'Eject Cheat', Callback = function()
					Library:LoadConfig(Library.OldConfig);
					Blur:Destroy();
					for _, Gui in Library.Guis do 
						Gui:Destroy() 
					end;
					for _, Connection in Library.Connections do 
						Connection:Disconnect() 
					end;
					for _, Inst in Library.Instances do 
						Inst:Destroy()
					end;
					Library = nil;
				end});
				--]]

				--// Esp Preview
				local Holder = Library:Panel({
					Name = 'Esp Preview', 
					AnchorPoint = NewVect2(0, 0),
					Size = Dim2(0, 300, 0, 325),
					Position = Dim2(0, Style.Items.MainHolder.AbsolutePosition.X, 0, Style.Items.MainHolder.AbsolutePosition.Y + Style.Items.MainHolder.AbsoluteSize.Y + 2),
					Image = getcustomasset(Library.Directory.. '/Assets/Images/Icon4.Png'),
				});
				
				local Items = Holder.Items
				
				local Column = Setmetatable(Items, Library):Column() 
				Window.EspSection = Column:Section({Name = 'Main'});
				local Esp = Window.EspSection:EspPreview({})
				--]]

				--// Playerlist 
				local Holder = Library:Panel({
					Name = 'Playerlist', 
					AnchorPoint = NewVect2(0, 0),
					Size = Dim2(0, 529, 0, 445),
					Position = Dim2(0, MainWindow.Items.MainHolder.AbsolutePosition.X - 531, 0, MainWindow.Items.MainHolder.AbsolutePosition.Y),
					Image = getcustomasset(Library.Directory.. '/Assets/Images/Icon5.Png'),
				});
				
				local Items = Holder.Items

				local Column = Setmetatable(Items, Library):Column() 
				local Section = Column:Section({Name = 'Playerlist'});
				Library.Playerlist = Section:Playerlist({});
				Section:Dropdown({Name = 'Priority', Items = {'Enemy', 'Priority', 'Neutral', 'Friendly'}, Default = 'Neutral', Flag = 'PlayerlistDropdown', Callback = function(Text)
					Library.Prioritize(Text)
				end});
				--]]

			return Setmetatable(Window, Library)
		end;

		function Library:EspPreview(Properties)
			local Cfg = {Items = {}, Rotation = 0; Objects = {};}
			if not (Client.Character.Archivable) then 
				Client.Character.Archivable = true
			end;
	
			local Character = Client.Character:Clone()
			Character.Animate:Destroy()

			local Items = Cfg.Items; do
				Items.ViewportFrame = Library:Create('ViewportFrame' , {
					Parent = self.Holder;
					BackgroundTransparency = 1;
					Size = Dim2(1, 0, 0, 220);
					BorderColor3 = FromRgb(0, 0, 0);
					ZIndex = 1;
					Position = Dim2(0, 0, 0, 10);
					BorderSizePixel = 0;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				Items.Camera = Library:Create('Camera' , {
					FieldOfView = 80;
					CameraType = Enum.CameraType.Track;
					CFrame = NewCF(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					Parent = gethui();
					-- Name = '\0'
				});

				Items.ViewportFrame.CurrentCamera = Items.Camera
				Character.Parent = Items.ViewportFrame

				Items.Camera.CameraSubject = Character;
				Character.SetPrimaryPartCFrame(Character, NewCF(NewVect3(0, 0, -5)) * NewAnglesCF(Rad(5), Rad(180), 0));

				Library:Connection(RunService.PostSimulation, function()
					if (not Library.MenuIsOpen and not Flags['Menu Spin Preview']) then return end;
					Cfg.Rotation += 0.75;
					Character.SetPrimaryPartCFrame(Character, NewCF(NewVect3(0, 0, -5)) * NewAnglesCF(Rad(5), Rad(Cfg.Rotation), 0))
				end);
            end;

			local Objects = Cfg.Objects; 
                do
				Objects['Holder'] = Library:Create('Frame' , {
					Parent = Items.ViewportFrame;
					-- Name = '\0';
					BackgroundTransparency = 1;
					Position = Dim2(0.5, 0, 0.5, 10);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(0, 135, 0, 190);
					BorderSizePixel = 0;
					AnchorPoint = NewVect2(0.5, 0.5);
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				Objects['BoxOutline'] = Library:Create('UIStroke' , {
					Parent = Library.Cache;
					LineJoinMode = Enum.LineJoinMode.Miter
				});
				
				Objects['Name'] = Library:Create('TextLabel' , {
					FontFace = Library.Font;
					Parent = Library.Cache;
					TextColor3 = Themes[Library.UTheme].Text;
					BorderColor3 = FromRgb(0, 0, 0);
					Text = FormatString('%s (@%s)', Client.DisplayName, Client.Name);
					-- Name = '\0';
					TextStrokeTransparency = 0;
					AnchorPoint = NewVect2(0, 1);
					Size = Dim2(1, 0, 0, 0);
					BackgroundTransparency = 1;
					Position = Dim2(0, 0, 0, -5);
					BorderSizePixel = 0;
					AutomaticSize = Enum.AutomaticSize.Y;
					TextSize = 10;
				});
				
				Objects['BoxHandler'] = Library:Create('Frame' , {
					Parent = Library.Cache;
					-- Name = '\0';
					BackgroundTransparency = 1;
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					BorderSizePixel = 0;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				Objects['BoxColor'] = Library:Create('UIStroke' , {
					Color = FromRgb(255, 255, 255);
					LineJoinMode = Enum.LineJoinMode.Miter;
					-- Name = '\0';
					Parent = Objects['BoxHandler']
				});
				
				Objects['Outline'] = Library:Create('Frame' , {
					Parent = Objects['BoxHandler'];
					-- Name = '\0';
					BackgroundTransparency = 1;
					Position = Dim2(0, 1, 0, 1);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -2, 1, -2);
					BorderSizePixel = 0;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				Library:Create('UIStroke' , {
					Parent = Objects['Outline'];
					LineJoinMode = Enum.LineJoinMode.Miter
				});
				
				--// Corner Boxes
					Objects['Corners'] = Library:Create('Frame' , {
						Visible = true;
						BorderColor3 = FromRgb(0, 0, 0);
						Parent = Library.Cache;
						BackgroundTransparency = 1;
						Position = Dim2(0, -1, 0, 2);
						-- Name = '\0';
						Size = Dim2(1, 0, 1, 0);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});

					Objects['1'] = Library:Create('Frame' , {
						Parent = Objects['Corners'];
						Name = 'Line';
						Position = Dim2(0, 0, 0, -2);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(0.4, 0, 0, 3);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(0, 0, 0)
					});
					
					Library:Create('Frame' , {
						Parent = Objects['1'];
						Position = Dim2(0, 1, 0, 1);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, -2);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					
					Objects['2'] = Library:Create('Frame' , {
						Parent = Objects['Corners'];
						Name = 'Line';
						Position = Dim2(0, 0, 0, 1);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(0, 3, 0.25, 0);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(0, 0, 0)
					});
					
					Library:Create('Frame' , {
						Parent = Objects['2'];
						Position = Dim2(0, 1, 0, -2);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, 1);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					
					Objects['3'] = Library:Create('Frame' , {
						AnchorPoint = NewVect2(1, 0);
						Parent = Objects['Corners'];
						Name = 'Line';
						Position = Dim2(1, 0, 0, -2);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(0.4, 0, 0, 3);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(0, 0, 0)
					});
					
					Library:Create('Frame' , {
						Parent = Objects['3'];
						Position = Dim2(0, 1, 0, 1);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, -2);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					
					Objects['4'] = Library:Create('Frame' , {
						AnchorPoint = NewVect2(1, 0);
						Parent = Objects['Corners'];
						Name = 'Line';
						Position = Dim2(1, 0, 0, 1);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(0, 3, 0.25, 0);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(0, 0, 0)
					});
					
					Library:Create('Frame' , {
						Parent = Objects['4'];
						Position = Dim2(0, 1, 0, -2);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, 1);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					
					Objects['5'] = Library:Create('Frame' , {
						AnchorPoint = NewVect2(0, 1);
						Parent = Objects['Corners'];
						Name = 'Line';
						Position = Dim2(0, -1, 1, -2);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(0.4, 0, 0, 3);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(0, 0, 0)
					});
					
					Library:Create('Frame' , {
						Parent = Objects['5'];
						Position = Dim2(0, 1, 0, 1);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, -2);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					
					Objects['6'] = Library:Create('Frame' , {
						BorderColor3 = FromRgb(0, 0, 0);
						Rotation = 180;
						Parent = Objects['Corners'];
						Name = 'Line';
						Position = Dim2(0, 0, 1, -4);
						AnchorPoint = NewVect2(0, 1);
						Size = Dim2(0, 3, 0.25, 1);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(0, 0, 0)
					});
					
					Library:Create('Frame' , {
						Parent = Objects['6'];
						Position = Dim2(0, 1, 0, -2);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, 1);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					
					Objects['7'] = Library:Create('Frame' , {
						AnchorPoint = NewVect2(1, 1);
						Parent = Objects['Corners'];
						Name = 'Line';
						Position = Dim2(1, -1, 1, -2);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(0.4, 0, 0, 3);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(0, 0, 0)
					});
					
					Library:Create('Frame' , {
						Parent = Objects['7'];
						Position = Dim2(0, 1, 0, 1);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, -2);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					
					Objects['7'] = Library:Create('Frame' , {
						BorderColor3 = FromRgb(0, 0, 0);
						Rotation = 180;
						Parent = Objects['Corners'];
						Name = 'Line';
						Position = Dim2(1, 0, 1, -4);
						AnchorPoint = NewVect2(1, 1);
						Size = Dim2(0, 3, 0.25, 1);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(0, 0, 0)
					});
					
					Library:Create('Frame' , {
						Parent = Objects['7'];
						Position = Dim2(0, 1, 0, -2);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, 1);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
				--//
				
				--// Healthbar
					Objects['HealthBar'] = Library:Create('Frame' , {
						AnchorPoint = NewVect2(1, 0);
						Parent = Library.Cache;
						-- Name = '\0';
						Position = Dim2(0, -5, 0, 0);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(0, 4, 1, 0);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(0, 0, 0)
					});
					
					Objects['HealthBar'] = Library:Create('Frame' , {
						Parent = Objects['HealthBar'];
						-- Name = '\0';
						Position = Dim2(0, 1, 0, 1);
						BorderColor3 = FromRgb(0, 0, 0);
						Size = Dim2(1, -2, 1, -2);
						BorderSizePixel = 0;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
				--// 

				--// Distance Esp
					Objects['Distance'] = Library:Create('TextLabel' , {
						FontFace = Library.Font;
						TextColor3 = Themes[Library.UTheme].Text;
						BorderColor3 = FromRgb(0, 0, 0);
						Text = '127st';
						Parent = Library.Cache;
						TextStrokeTransparency = 0;
						-- Name = '\0';
						Size = Dim2(1, 0, 0, 0);
						BackgroundTransparency = 1;
						Position = Dim2(0, 0, 1, 5);
						BorderSizePixel = 0;
						AutomaticSize = Enum.AutomaticSize.Y;
						TextSize = 10;
					});
				--// 

				--// Weapon Esp
					Objects['Weapon'] = Library:Create('TextLabel' , {
						FontFace = Library.Font;
						TextColor3 = Themes[Library.UTheme].Text;
						BorderColor3 = FromRgb(0, 0, 0);
						Text = '[ Weapon ]';
						Parent = Library.Cache;
						TextStrokeTransparency = 0;
						-- Name = '\0';
						Size = Dim2(1, 0, 0, 0);
						BackgroundTransparency = 1;
						Position = Dim2(0, 0, 1, 19);
						BorderSizePixel = 0;
						AutomaticSize = Enum.AutomaticSize.Y;
						TextSize = 10;
				});
			end; 

			Cfg.ChangeHealth = function()
				if Flags['HealthBar'] and Flags['HealthBar'].Parent ~= Objects['Holder'] then 
					return 
				end;

				local Humanoid = Character.Humanoid
				
				-- local Multiplier = Humanoid.MaxHealth * Abs(Sin(Library.Tick * 2)) / Humanoid.MaxHealth
				local Color = FromRgb(200, 0, 0):Lerp(FromRgb(0, 200, 0), Multiplier)
				
				Objects['HealthBar'].Size = Dim2(1, -2, Multiplier, -2)
				Objects['HealthBar'].Position = Dim2(0, 1, 1 - Multiplier, 1)
				Objects['HealthBar'].BackgroundColor3 = Color
			end;

			function Cfg.RefreshElements()
				Objects.Holder.Parent = Flags['Enabled'] and Items.ViewportFrame or Library.Cache

				local Temp = {
					['Names'] = Objects['Name']; 
					['NameTextColor'] = {Objects['Name']};
					['Healthbar'] = Objects['HealthBar'];
					['Distance'] = Objects['Distance'];
					['Weapon'] = Objects['Weapon'];
					['DistanceColor'] = {Objects['Distance']};
					['WeaponColor'] = {Objects['Weapon']};
				}

				for Flag, Object in Temp do 
					if type(Object) == 'table' then 
						Object[1].TextColor3 = Flags[Flag].Color
					else 
						Object.Parent = Flags[Flag] and Objects['Holder'] or Library.Cache
					end;
				end; 
				
				local IsCorner = Flags['BoxType'] == 'Corner'

				if Flags['Boxes'] then 
					if IsCorner then 
						Objects['Corners'].Parent = Objects['Holder']
						Objects['BoxHandler'].Parent = Library.Cache
						Objects['BoxOutline'].Parent = Library.Cache
					else 
						Objects['BoxHandler'].Parent = Objects['Holder']
						Objects['BoxOutline'].Parent = Objects['Holder']
						Objects['Corners'].Parent = Library.Cache
					end; 
				else
					Objects['Corners'].Parent = Library.Cache
					Objects['BoxHandler'].Parent = Library.Cache
					Objects['BoxOutline'].Parent = Library.Cache
				end; 

				Objects['BoxColor'].Color = Flags['BoxColor'].Color 

				for _, Corner in Objects['Corners']:GetChildren() do
					Corner.Frame.BackgroundColor3 = FromRgb(255, 255, 255)
				end;
			end;
		--[[
			Library:Connection(RunService.RenderStepped, function()
				if shared.MenuIsOpen then
					Cfg.ChangeHealth()
				end;
			end)
		]]
			return Setmetatable(Cfg, Library)
		end;

		function Library:RefreshNotifications()
			for _, Notif in next, Library.Notifications do 
				TweenService:Create(Notif, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {Position = Dim2(0, 20, 0, 72 + (_ * 28))}):Play()
			end;
		end;

		function Library:Notification(Properties)
			local Cfg = {
				Time = Properties.Time or 5,
				Text = Properties.Text or Properties.Name or 'Notification',
			}
		
			--// Instances
				local NotificationOutline = Library:Create('Frame', {
					Parent = NotifHolder,
					-- Name = '',
					Size = Dim2(0, 0, 0, 24),
					BorderColor3 = FromRgb(0, 0, 0),
					BorderSizePixel = 0,
					Position = Dim2(0, 20, 0, 72 + (#Library.Notifications * 28)),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = Themes[Library.UTheme].Outline,
					AnchorPoint = NewVect2(1, 0)
				});
			
				local NotificationInline = Library:Create('Frame', {
					Parent = NotificationOutline,
					-- Name = '',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});

				local WatermarkBackground = Library:Create('Frame', {
					Parent = NotificationInline,
					-- Name = '',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
		
				local UIGradient = Library:Create('UIGradient', {
					Parent = WatermarkBackground,
					-- Name = '',
					Color = ColorSeq{ColorKey(0, Themes[Library.UTheme].LowContrast), ColorKey(1, Themes[Library.UTheme].HighContrast)}
				});
		
				local Text = Library:Create('TextLabel', {
					Parent = WatermarkBackground,
					-- Name = '',
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '  ' .. Cfg.Text .. '  ',
					Size = Dim2(0, 0, 1, 0),
					BackgroundTransparency = 1,
					Position = Dim2(0, 0, 0, -1),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
		
				local Accent = Library:Create('Frame', {
					Parent = NotificationOutline,
					-- Name = '',
					Position = Dim2(0, 2, 0, 2),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 1, 1, -4),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Accent
				});

				Library:ApplyTheme(Accent, 'Accent', 'BackgroundColor3')
		
				local UIGradient = Library:Create('UIGradient', {
					Parent = Accent,
					-- Name = '',
					Rotation = 90,
					--Transparency
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(167, 167, 167))}
				});
				
				local AccentBottom = Library:Create('Frame', {
					Parent = NotificationOutline,
					-- Name = '',
					Position = Dim2(0, 2, 1, -3),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, -4, 0, 1),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Accent
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Accent,
					-- Name = '',
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(167, 167, 167))}
				});

				local index = #Library.Notifications + 1
				Library.Notifications[index] =NotificationOutline

				Library:RefreshNotifications()

				TweenService:Create(NotificationOutline, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {AnchorPoint = NewVect2(0, 0)}):Play()
				
				TweenService:Create(AccentBottom, TweenInfo.new(Cfg.Time, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = Dim2(1, -4, 0, 1)}):Play()
			--
			
			Spawn(function()
				Wait(Cfg.Time)

				Library.Notifications[index] = nil

				TweenService:Create(NotificationOutline, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {AnchorPoint = NewVect2(1, 0), BackgroundTransparency = 1}):Play()
				
				for _, v in next, NotificationOutline:GetDescendants() do 
					if v:IsA('TextLabel') then
						TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency = 1}):Play()
					elseif v:IsA('Frame') then
						TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 1}):Play()
					elseif v:IsA('ImageLabel') then
						TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency = 1}):Play()
					elseif v:IsA('UIStroke') then
						TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Transparency = 1}):Play()
					end;
				end;

				Wait(1.5)

				NotificationOutline:Destroy()
			end)
		end;

		function Library:Tab(Options)	
			local Cfg = {
				Name = Options.Name or 'Tab', 
				Enabled = false, 
			}
			
			--// Button Instances
				local TabHolder = Library:Create('TextButton', {
					Parent = self.TabHolder,
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '',
					-- Name = '\0',
					BorderSizePixel = 0,
					Size = Dim2(0, 0, 1, -2),
					ZIndex = 5,
					TextSize = 10;
					BackgroundColor3 = Themes[Library.UTheme].Outline,
					AutoButtonColor = false
				});
				Library:ApplyTheme(TabHolder, 'Outline', 'BackgroundColor3')

				local Inline = Library:Create('Frame', {
					Parent = TabHolder,
					Size = Dim2(1, -2, 1, 0),
					-- Name = '\0',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					ZIndex = 5,
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')

				local Background = Library:Create('Frame', {
					Parent = Inline,
					Size = Dim2(1, -2, 1, -1),
					-- Name = '\0',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					ZIndex = 5,
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});

				local UIGradient = Library:Create('UIGradient', {
					Parent = Background,
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')

				local Text = Library:Create('TextLabel', {
					Parent = Background,
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = Cfg.Name,
					-- Name = '\0',
					BackgroundTransparency = 1,
					Size = Dim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 10;
					ZIndex = 5,
					BackgroundColor3 = FromRgb(255, 255, 255)
				}, 'Text')
				Library:ApplyTheme(Text, 'Accent', 'TextColor3')

				local SectionHolder = Library:Create('Frame', {
					Parent = Library.SectionHolder,
					BackgroundTransparency = 1,
					-- Name = '\0',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					Visible = false,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
			
				Cfg['Holder'] = SectionHolder

				Library:Create('UIListLayout', {
					Parent = SectionHolder,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = NewDim(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder
				});

			function Cfg.OpenTab()
				if Library.CurrentTab and Library.CurrentTab[1] ~= Background then
					local Button = Library.CurrentTab[1]
					Button.Size = Dim2(1, -2, 1, -1)
					Button:FindFirstChildOfClass('UIGradient').Rotation = 90
					Button:FindFirstChildOfClass('TextLabel').TextColor3 = Themes[Library.UTheme].Text
						
					Library.CurrentTab[2].Visible = false
					
					Library.CurrentTab = nil
				end;
				
				Library.CurrentTab = {Background, SectionHolder}
				
				local Button = Library.CurrentTab[1] 
				Button.Size = Dim2(1, -2, 1, 0) --// Enabled
				Button:FindFirstChildOfClass('UIGradient').Rotation = -90
				Button:FindFirstChildOfClass('TextLabel').TextColor3 = Themes[Library.UTheme].Accent 

				Library.CurrentTab[2].Visible = true 

				if Library.CurrentElementOpened and Library.CurrentElementOpened ~= Cfg then
					Library.CurrentElementOpened.SetVisible(false)
					Library.CurrentElementOpened.Open = false 
					Library.CurrentElementOpened = nil 
				end;
			end;
			
			TabHolder.MouseButton1Click:Connect(Cfg.OpenTab)
			
			return Setmetatable(Cfg, Library) 
		end;

		function Library:Column(Path) 
			local Cfg = {}
			
			local Holder = Path or self.Holder
			
			local Column = Library:Create('Frame', {
				Parent = Holder,
				BackgroundTransparency = 1,
				-- Name = '\0',
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Inline
			});
			Library:ApplyTheme(Column, 'Inline', 'BackgroundColor3')
			
			Library:Create('UIListLayout', {
				Parent = Column,
				Padding = NewDim(0, 4),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalFlex = Enum.UIFlexAlignment.Fill
			});
			
			Cfg['Holder'] = Column

			return Setmetatable(Cfg, Library) 
		end;

		function Library:MultiSection(Options)
			local Cfg = {
				Names = Options.Names or {'First', 'Second', 'Third'}, 
				Sections = {},
			}

			local Section = Library:Create('Frame', {
				Parent = self.Holder,
				-- Name = '',
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Inline
			});
			Library:ApplyTheme(Section, 'Inline', 'BackgroundColor3')
			
			local Inline = Library:Create('Frame', {
				Parent = Section,
				-- Name = '',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Outline
			});
			Library:ApplyTheme(Inline, 'Outline', 'BackgroundColor3')
			
			local __Background = Library:Create('Frame', {
				Parent = Inline,
				-- Name = '',
				ClipsDescendants = true,
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				ZIndex = 1,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			
			local Accent = Library:Create('Frame', {
				Parent = __Background,
				-- Name = '',
				Size = Dim2(1, 0, 0, 2),
				BorderColor3 = FromRgb(0, 0, 0),
				ZIndex = 3,
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Accent
			});
			Library:ApplyTheme(Accent, 'Accent', 'BackgroundColor3')
			
			local UIGradient = Library:Create('UIGradient', {
				Parent = Accent,
				-- Name = '',
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(167, 167, 167))}
			});
			
			local UIGradient = Library:Create('UIGradient', {
				Parent = __Background,
				-- Name = '',
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
			});
			Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
			
			local TabHolder = Library:Create('Frame', {
				Parent = __Background,
				-- Name = '',
				ClipsDescendants = true,
				BackgroundTransparency = 1,
				Position = Dim2(0, -1, 0, 0),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, 2, 0, 21),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			
			Library:Create('UIListLayout', {
				Parent = TabHolder,
				-- Name = '',
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = NewDim(0, -3),
				SortOrder = Enum.SortOrder.LayoutOrder
			});
			
			for _, Tab in next, Cfg.Names do 
				local Multi = {Open = false} 

				--// Tab
					local Tabb = Library:Create('TextButton', {
						Parent = TabHolder,
						-- Name = '',
						AutoButtonColor = false,
						FontFace = Library.Font,
						TextColor3 = Themes[Library.UTheme].Text,
						BorderColor3 = FromRgb(0, 0, 0),
						Text = '',
						BorderSizePixel = 0,
						Size = Dim2(0, 0, 1, 0),
						ZIndex = 1,
						TextSize = 10;
						BackgroundColor3 = Themes[Library.UTheme].Outline
					});
					Library:ApplyTheme(Tabb, 'Outline', 'BackgroundColor3')
					
					local Background = Library:Create('Frame', {
						Parent = Tabb,
						-- Name = '',
						Size = Dim2(1, 0, 1, -2),
						Position = Dim2(0, 1, 0, 1),
						BorderColor3 = FromRgb(0, 0, 0),
						ZIndex = 1,
						BorderSizePixel = 0,
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					
					local UIGradient = Library:Create('UIGradient', {
						Parent = Background,
						-- Name = '',
						Rotation = 90,
						Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
					});
					Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
					
					local Text = Library:Create('TextLabel', {
						Parent = Background,
						-- Name = '',
						FontFace = Library.Font,
						TextColor3 = Themes[Library.UTheme].Text,
						BorderColor3 = FromRgb(0, 0, 0),
						Text = Tab,
						BackgroundTransparency = 1,
						Size = Dim2(1, 0, 1, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.X,
						TextSize = 10;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					Library:ApplyTheme(Text, 'Accent', 'TextColor3')
					
					local UIStroke = Library:Create('UIStroke', {
						Parent = Text,
						-- Name = '',
						LineJoinMode = Enum.LineJoinMode.Miter
					});
				--// 

				--// Element Handler
					local ScrollingFrame = Library:Create('ScrollingFrame', {
						Parent = __Background,
						-- Name = '',
						ScrollBarImageColor3 = Themes[Library.UTheme].Accent,
						Active = true,
						MidImage = getcustomasset(Library.Directory.. '/Assets/Images/White.Png'),
						TopImage = MidImage,
						BottomImage = MidImage,
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						ScrollBarThickness = 2,
						Size = Dim2(1, 0, 1, -20),
						Visible = false, 
						BackgroundTransparency = 1,
						Position = Dim2(0, 0, 0, 24),
						BackgroundColor3 = FromRgb(255, 255, 255),
						BorderColor3 = FromRgb(0, 0, 0),
						BorderSizePixel = 0,
						ScrollBarThickness = 2,
						CanvasSize = Dim2(0, 0, 0, 0)
					});
					Library:ApplyTheme(ScrollingFrame, 'Accent', 'ScrollBarImageColor3')
					
					local Elements = Library:Create('Frame', {
						Parent = ScrollingFrame,
						-- Name = '',
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(1, 0, 0, 0),
						BorderSizePixel = 0,
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					Multi.Holder = Elements
					
					local UIListLayout = Library:Create('UIListLayout', {
						Parent = Elements,
						-- Name = '',
						SortOrder = Enum.SortOrder.LayoutOrder,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						Padding = NewDim(0, 4)
					});
					
					local UIPadding = Library:Create('UIPadding', {
						Parent = ScrollingFrame,
						-- Name = '',
						PaddingBottom = NewDim(0, 60)
					});
				--
				
				function Multi:OpenTab(Boolean) 
					ScrollingFrame.Visible = Boolean 
					UIGradient.Rotation = Boolean and -90 or 90
					Tabb.Size = Dim2(0, 0, 1, Boolean and 1 or 0)
					Text.TextColor3 = Boolean and Themes[Library.UTheme].Accent or Themes[Library.UTheme].Text
				end;

				Library:Connection(Tabb.MouseButton1Click, function()
					for _, Multis in next, Cfg.Sections do 
						Multis:OpenTab(false)
					end;

					if Library.CurrentElementOpened then
						Library.CurrentElementOpened.SetVisible(false)
						Library.CurrentElementOpened.Open = false 
						Library.CurrentElementOpened = nil 
					end;

					Multi:OpenTab(true) 
				end)

				Cfg.Sections[#Cfg.Sections + 1] = Setmetatable(Multi, Library)
			end;

			Cfg.Sections[1]:OpenTab(true)

			return unpack(Cfg.Sections)
		end;

		function Library:Section(Options)
			local Cfg = {
				Name = Options.Name or 'Section', 
			}
			
			local Section = Library:Create('Frame', {
				Parent = self.Holder,
				-- Name = '\0',
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Inline
			});
			Library:ApplyTheme(Section, 'Inline', 'BackgroundColor3')

			local Inline = Library:Create('Frame', {
				Parent = Section,
				-- Name = '\0',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Outline
			});
			Library:ApplyTheme(Inline, 'Outline', 'BackgroundColor3')

			local Background = Library:Create('Frame', {
				Parent = Inline,
				-- Name = '\0',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});

			local Text = Library:Create('TextLabel', {
				Parent = Background,
				FontFace = Library.Font,
				TextColor3 = Themes[Library.UTheme].Text,
				BorderColor3 = FromRgb(0, 0, 0),
				Text = Cfg.Name,
				-- Name = '\0',
				BackgroundTransparency = 1,
				Position = Dim2(0, 6, 0, 4),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.XY,
				TextSize = 10;
				BackgroundColor3 = FromRgb(255, 255, 255)
			});

			Library:Create('UIStroke', {
				Parent = Text,
				LineJoinMode = Enum.LineJoinMode.Miter
			});

			local Accent = Library:Create('Frame', {
				Parent = Background,
				-- Name = '\0',
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, 0, 0, 2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Accent
			});
			Library:ApplyTheme(Accent, 'Accent', 'BackgroundColor3')

			local UIGradient = Library:Create('UIGradient', {
				Parent = Accent,
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(167, 167, 167))}
			});

			local UIGradient = Library:Create('UIGradient', {
				Parent = Background,
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
			});
			Library:ApplyTheme(UIGradient, 'Contrast', 'Color')

			local ScrollingFrame = Library:Create('ScrollingFrame', {
				Parent = Background,
				ScrollBarImageColor3 = Themes[Library.UTheme].Accent,
				Active = true,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollBarThickness = 2,
				MidImage = getcustomasset(Library.Directory.. '/Assets/Images/White.Png'),
				TopImage = MidImage,
				BottomImage = MidImage,
				Size = Dim2(1, 0, 1, -20),
				BackgroundTransparency = 1,
				Position = Dim2(0, 0, 0, 20),
				BackgroundColor3 = FromRgb(255, 255, 255),
				BorderColor3 = FromRgb(0, 0, 0),
				BorderSizePixel = 0,
				CanvasSize = Dim2(0, 0, 0, 0)
			});
			Library:ApplyTheme(ScrollingFrame, 'Accent', 'ScrollBarImageColor3')

			ScrollingFrame:GetPropertyChangedSignal('CanvasPosition'):Connect(function()
				if Library.CurrentElementOpened then
					Library.CurrentElementOpened.SetVisible(false)
					Library.CurrentElementOpened.Open = false 
					Library.CurrentElementOpened = nil
				end;
			end)

			local Elements = Library:Create('Frame', {
				Parent = ScrollingFrame,
				-- Name = '\0',
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, 0, 0, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			Cfg.Holder = Elements 

			Library:Create('UIListLayout', {
				Parent = Elements,
				Padding = NewDim(0, 4),
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder
			});

			Library:Create('UIPadding', {
				Parent = ScrollingFrame,
				PaddingBottom = NewDim(0, 10)
			});

			return Setmetatable(Cfg, Library)
		end;

		function Library:Slider(Options)
			local Cfg = {
				Name = Options.Name or nil,
				Suffix = Options.Suffix or '',
				Flag = (Options.Flag or '(Slider) EMPTY FLAG: '),
				Callback = Options.Callback or function() end; 
				Visible = Options.Visible or true, 
				InputDisabled = Options.InputDisabled or false,
				CustomColor = Options.Custom or nil;

				Min = Options.Min or Options.Minimum or 0,
				Max = Options.Max or Options.Maximum or 100,
				Intervals = Options.Interval or Options.Decimal or 1,
				Default = Options.Default or 10,

				Dragging = false,
				Value = Options.Default or 10, 
			};

			--// Instances 
				local RealSlider = Library:Create('TextLabel', {
					Parent = self.Holder, 
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '',
					Name = 'Slider',
					ZIndex = 1,
					Size = Dim2(1, -8, 0, 12),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local TextLabel;
				if Cfg.Name then
					local LeftComponents = Library:Create('Frame', {
						Parent = RealSlider,
						Name = 'LeftComponents',
						BackgroundTransparency = 1,
						Position = Dim2(0, 2, 0, -1),
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(0, 0, 0, 14),
						BorderSizePixel = 0,
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					
					TextLabel = Library:Create('TextLabel', {
						Parent = LeftComponents,
						FontFace = Library.Font,
						TextColor3 = Themes[Library.UTheme].Text,
						BorderColor3 = FromRgb(0, 0, 0),
						Text = Cfg.Name,
						Name = 'Text',
						BackgroundTransparency = 1,
						Size = Dim2(0, 0, 1, -1),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.X,
						TextSize = 10;
						BackgroundColor3 = FromRgb(255, 255, 255)
					}, 'Text')

					Library:Create('UIListLayout', {
						Parent = LeftComponents,
						Padding = NewDim(0, 5),
						-- Name = '',
						FillDirection = Enum.FillDirection.Horizontal
					});
				end;
				
				local BottomComponents = Library:Create('Frame', {
					Parent = RealSlider,
					Name = 'BottomComponents',
					Position = Dim2(0, 0, 0, Cfg.Name and 15 or 0),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 0, 0, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local Slider = Library:Create('TextButton', {
					Parent = BottomComponents,
					Name = 'Slider',
					Position = Dim2(0, 0, 0, 2),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -1, 1, 12),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline,
					Text = '',
					AutoButtonColor = false,
				});
				Library:ApplyTheme(Slider, 'Outline', 'BackgroundColor3')

				if not Cfg.InputDisabled then
					Library:Hover(RealSlider, Slider)
				end;

				local Inline = Library:Create('Frame', {
					Parent = Slider,
					Name = 'Inline',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					ZIndex = 1;
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')

				local Background = Library:Create('Frame', {
					Parent = Inline,
					Name = 'Background',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
				});
				
				local Contrast = Library:Create('Frame', {
					Parent = Background,
					Name = 'Contrast',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local SliderText = Library:Create('TextLabel', {
					Parent = Contrast,
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '12.50/100.00',
					Name = 'Text',
					BackgroundTransparency = 1,
					Position = Dim2(0, 0, 0, -1),
					Size = Dim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					TextSize = 10;
					ZIndex = 2,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local Fill = Library:Create('Frame', {
					Parent = Contrast,
					Name = 'Fill',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Cfg.CustomColor or Themes[Library.UTheme].Accent
				});
				if not Cfg.CustomColor then Library:ApplyTheme(Fill, 'Accent', 'BackgroundColor3') end;

				local UIGradient = Library:Create('UIGradient', {
					Parent = Fill,
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(0.5, FromRgb(90, 90, 90)), ColorKey(1, FromRgb(60, 60, 60))}
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Contrast,
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Background,
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(167, 167, 167))}
				});
				
				Library:Create('UIListLayout', {
					Parent = BottomComponents,
					Padding = NewDim(0, 10),
					-- Name = '',
					SortOrder = Enum.SortOrder.LayoutOrder
				});
			--//
				function Cfg.Set(Value)
					if typeof(Value) ~= 'number' then return end;
					Cfg.Value = Clamp(Library:Round(Value, Cfg.Intervals), Cfg.Min, Cfg.Max)
					Library:Tween(Fill, {Size = Dim2((Cfg.Value - Cfg.Min) / (Cfg.Max - Cfg.Min), 0, 1, 0)}, 0.045);

					SliderText.Text = (Tostring(Cfg.Value).. ' ' .. Cfg.Suffix .. ' / ' .. Tostring(Cfg.Max).. ' ' .. Cfg.Suffix)
					Flags[Cfg.Flag] = Cfg.Value

					Cfg.Callback(Flags[Cfg.Flag])
				end;

				function Cfg.SetElementVisible(Boolean)
					-- if not (TextLabel) then return end;
					RealSlider.Visible = Boolean;
					TextLabel.Visible = Boolean;
				end;

				if (not Cfg.InputDisabled) then
					Library:Connection(InputService.InputChanged, function(Input)
						if (Cfg.Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement) then
							local SizeX = (Input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X
							local Value = ((Cfg.Max - Cfg.Min) * SizeX) + Cfg.Min
							Cfg.Set(Value)
						end;
					end)

					Library:Connection(InputService.InputEnded, function(Input)
						if (Input.UserInputType == Enum.UserInputType.MouseButton1) then
							Cfg.Dragging = false 
						end;
					end)

					Slider.MouseButton1Down:Connect(function()
						Cfg.Dragging = true
					end)
				end;

				Cfg.Set(Cfg.Default)
				Cfg.SetElementVisible(Cfg.Visible)
						
				ConfigFlags[Cfg.Flag] = Cfg.Set

				Library.ConfigFlags[Cfg.Flag] = Cfg.Set
				Library.VisibleFlags[Cfg.Flag] = Cfg.SetElementVisible

				return Setmetatable(Cfg, Library) 
			end;

		function Library:Toggle(Options)
			local Cfg = {
				Enabled = Options.Enabled or nil,
				Name = Options.Name or 'Toggle',
				Flag = (Options.Flag or '(Toggle) EMPTY FLAG: '),
				Callback = Options.Callback or function() end;
				Default = Options.Default or false,
				Colorpicker = Options.Color or nil,
				Visible = Options.Visible or true,
			}

			--// Instances
				local ToggleHolder = Library:Create('TextButton', {
					Parent = self.Holder,
					FontFace = Library.Font,
					TextColor3 = FromRgb(151, 151, 151),
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '',
					Name = 'Toggle',
					ZIndex = 1,
					Size = Dim2(1, -8, 0, 12),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local RightComponents = Library:Create('Frame', {
					Parent = ToggleHolder,
					Name = 'RightComponents',
					Position = Dim2(1, -1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 0, 0, 12),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				Cfg['RightHolder'] = RightComponents
			
				local List = Library:Create('UIListLayout', {
					Parent = RightComponents,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Padding = NewDim(0, 4),
					Name = 'List',
					SortOrder = Enum.SortOrder.LayoutOrder
				});
			
				Library:Create('UIPadding', {
					Parent = ToggleHolder
				});
			
				local LeftComponents = Library:Create('Frame', {
					Parent = ToggleHolder,
					Name = 'LeftComponents',
					BackgroundTransparency = 1,
					Position = Dim2(0, 0, 0, 0),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 0, 0, 14),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local Text = Library:Create('TextLabel', {
					Parent = LeftComponents,
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = Cfg.Name,
					Name = 'Text',
					BackgroundTransparency = 1,
					Size = Dim2(0, 0, 1, -1),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
			
				Library:Create('UIStroke', {
					Parent = Text,
					LineJoinMode = Enum.LineJoinMode.Miter
				});
			
				Library:Create('UIListLayout', {
					Parent = LeftComponents,
					Padding = NewDim(0, 5),
					-- Name = '',
					FillDirection = Enum.FillDirection.Horizontal
				});
			
				local Toggle = Library:Create('TextButton', {
					Parent = LeftComponents,
					Name = '!Toggle',
					Text = '',
					AutoButtonColor = false,
					Position = Dim2(0, 0, 0, 2),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 14, 0, 14),
					BorderSizePixel = 0,
					ZIndex = 1, 
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Toggle, 'Outline', 'BackgroundColor3')
				Library:ApplyTheme(Toggle, 'Accent', 'BackgroundColor3')

				local Inline = Library:Create('Frame', {
					Parent = Toggle,
					Name = 'Inline',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					ZIndex = 2;
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')
			
				local Accent = Library:Create('Frame', {
					Parent = Inline,
					BackgroundTransparency = 1;
					ZIndex = 3;
					Name = 'Background',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Accent
				});
				Library:ApplyTheme(Accent, 'Accent', 'BackgroundColor3')

				local UIGradient = Library:Create('UIGradient', {
					Parent = Accent,
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(25, 25, 25))}
				});

				local Background = Library:Create('Frame', {
					Parent = Inline,
					ZIndex = 2;
					Name = 'Background',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				Library:ApplyTheme(Background, 'Accent', 'BackgroundColor3')

				local UIGradient = Library:Create('UIGradient', {
					Parent = Background,
					Rotation = 90,
					-- Name = '',
					Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
			--//

			Library:Hover(ToggleHolder, Toggle)
				
			function Cfg.Set(Boolean)
				if typeof(Boolean) ~= 'boolean' then return end;
				Library:Tween(Accent, {BackgroundTransparency = Boolean and 0 or 1}, 0.185);
				Flags[Cfg.Flag] = Boolean
				Cfg.Callback(Boolean)
			end;

			function Cfg.SetElementVisible(Boolean)
				ToggleHolder.Visible = Boolean
			end;
		
			Library:Connection(ToggleHolder.MouseButton1Click, function()
				Cfg.Enabled = not (Cfg.Enabled)
				Cfg.Set(Cfg.Enabled)
			end)

			Library:Connection(Toggle.MouseButton1Click, function()
				Cfg.Enabled = not (Cfg.Enabled)
				Cfg.Set(Cfg.Enabled)
			end)

			Cfg.Set(Cfg.Default)
			
			Cfg.SetElementVisible(Cfg.Visible)
			
			Library.ConfigFlags[Cfg.Flag] = Cfg.Set
			Library.VisibleFlags[Cfg.Flag] = Cfg.SetElementVisible

			return Setmetatable(Cfg, Library)
		end;
		
		function Library:Colorpicker(Options)
			local Parent = self.RightHolder
			
			local Cfg = {
				Name = Options.Name or 'Color', 
				Flag = (Options.Flag or '(Colorpicker) EMPTY FLAG: '),
				Color = (Options.Color or FromRgb(255, 255, 255)),
				Callback = (Options.Callback or function() end),
				RightHolder = self.RightHolder,
			}

			local DraggingSat, DraggingHue = false
			local H, s, v
			if Cfg.Color then
				H, s, v = (Cfg.Color:ToHSV())
			else
				H, s, v = 0
			end;
			--// Colorpicker Button 
				local ColorpickerButton = Library:Create('TextButton', {
					Parent = Parent,
					Name = 'Outline',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 24, 0, 14),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline,
					Text = '',
					AutoButtonColor = false,
				});
				Library:ApplyTheme(ColorpickerButton, 'Outline', 'BackgroundColor3')
			
				local Inline = Library:Create('Frame', {
					Parent = ColorpickerButton,
					Name = 'Inline',
					ZIndex = 2;
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')
			
				local Handler = Library:Create('Frame', {
					Parent = Inline,
					Name = 'Handler',
					ZIndex = 2;
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(250, 165, 27)
				});

				Library:Hover(ColorpickerButton, ColorpickerButton)
			
				local UIGradient = Library:Create('UIGradient', {
					Parent = Handler,
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(25, 25, 25))}
				});
			--// 

			--// Colorpicker Instances
				local ColorpickerHolder = Library:Create('Frame', {
					Parent = SGui,
					Name = 'Colorpicker',
					Position = Dim2(0, ColorpickerButton.AbsolutePosition.X + 1, 0, ColorpickerButton.AbsolutePosition.Y + 17),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 190, 0, 210),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline,
					Visible = false,
					ZIndex = 1
				});
				Library:ApplyTheme(ColorpickerHolder, 'Outline', 'BackgroundColor3')

				Library:Resizeable(ColorpickerHolder)
				
				local WindowInline = Library:Create('Frame', {
					Parent = ColorpickerHolder,
					Name = 'WindowInline',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Accent
				});
				Library:ApplyTheme(WindowInline, 'Accent', 'BackgroundColor3')
				
				local WindowHolder = Library:Create('Frame', {
					Parent = WindowInline,
					Name = 'WindowHolder',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = Themes[Library.UTheme].Outline,
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});

				local UIGradient = Library:Create('UIGradient', {
					Parent = WindowHolder,
					Rotation = 90,
					-- Name = '',
					Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				local Text = Library:Create('TextLabel', {
					Parent = WindowHolder,
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = Cfg.Name,
					Name = 'Text',
					BackgroundTransparency = 1,
					Position = Dim2(0, 2, 0, 4),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				Library:Create('UIStroke', {
					Parent = Text,
					LineJoinMode = Enum.LineJoinMode.Miter
				});
				
				Library:Create('UIPadding', {
					Parent = WindowHolder,
					-- Name = '',
					PaddingBottom = NewDim(0, 4),
					PaddingRight = NewDim(0, 4),
					PaddingLeft = NewDim(0, 4)
				});
				
				local MainHolder = Library:Create('Frame', {
					Parent = WindowHolder,
					Name = 'MainHolder',
					Position = Dim2(0, 0, 0, 20),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 0, 1, -40),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(MainHolder, 'Inline', 'BackgroundColor3')
				
				Cfg.Holder = Library:Create('Frame' , {
					Parent = ColorpickerHolder;
					-- Name = '\0';
					Position = Dim2(0, 6, 1, -21);
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, -120, 0, 0);
					BorderSizePixel = 0;
				});
				
				local RainbowToggle = Setmetatable(Cfg, Library):Toggle({Name = 'Rainbow', Flag = Cfg.Flag .. ' RainbowFlag'});

				Cfg.Holder = Library:Create('Frame' , {
					Parent = ColorpickerHolder;
					-- Name = '\0';
					Position = Dim2(1, 2, 1, -23);
					BorderColor3 = FromRgb(0, 0, 0);
					AnchorPoint = NewVect2(1, 0);
					Size = Dim2(1, -80, 0, 0);
					BorderSizePixel = 0;
				});
				
				local Section = Setmetatable(Cfg, Library)
				Section:ButtonHolder({});
				Section:Button({Name = 'Copy', Callback = function()
					Library.CopiedFlag = Flags[Cfg.Flag];
					if (Cfg.Flag .. ' RainbowFlag') == true then
						Library.IsRainbow = (Cfg.Flag .. ' RainbowFlag');
					end;
				end});
				Section:Button({Name = 'Paste', Callback = function()
					RainbowToggle.Set(Library.IsRainbow or false);
					Cfg.Set(Library.CopiedFlag.Color);
				end});

				local MainHolderInline = Library:Create('Frame', {
					Parent = MainHolder,
					Name = 'MainHolderInline',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(MainHolderInline, 'Outline', 'BackgroundColor3')
				
				local MainHolderBackground = Library:Create('Frame', {
					Parent = MainHolderInline,
					Name = 'MainHolderBackground',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = MainHolderBackground,
					Rotation = 90,
					-- Name = '',
					Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				Library:Create('UIPadding', {
					Parent = MainHolderBackground,
					PaddingTop = NewDim(0, 4),
					-- Name = '',
					PaddingBottom = NewDim(0, 4),
					PaddingRight = NewDim(0, 4),
					PaddingLeft = NewDim(0, 4)
				});
				
				local Hue = Library:Create('TextButton', {
					Parent = MainHolderBackground,
					AnchorPoint = NewVect2(1, 0),
					Name = 'Hue',
					Position = Dim2(1, -1, 0, 0),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 14, 1, -20),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline,
					Transparency = 1,
					Text = '',
					AutoButtonColor = false
				});
				
				local Outline = Library:Create('Frame', {
					Parent = Hue,
					Name = 'Outline',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				
				local Frame = Library:Create('Frame', {
					Parent = Outline,
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Frame,
					Rotation = 270,
					Color = ColorSeq{ColorKey(0, FromRgb(255, 0, 0)), ColorKey(0.17, FromRgb(255, 255, 0)), ColorKey(0.33, FromRgb(0, 255, 0)), ColorKey(0.5, FromRgb(0, 255, 255)), ColorKey(0.67, FromRgb(0, 0, 255)), ColorKey(0.823, FromRgb(255, 0, 255)), ColorKey(1, FromRgb(255, 0, 0))}
				});
				
				local HuePicker = Library:Create('Frame', {
					Parent = Frame,
					Name = 'HuePicker',
					BorderMode = Enum.BorderMode.Inset,
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 0, 0, 4),
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local Visualize = Library:Create('Frame', {
					Parent = MainHolderBackground,
					AnchorPoint = NewVect2(1, 1),
					Name = 'Visualize',
					Position = Dim2(1, -1, 1, -1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 14, 0, 14),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Visualize, 'Inline', 'BackgroundColor3')
				
				local Outline = Library:Create('Frame', {
					Parent = Visualize,
					Size = Dim2(1, -2, 1, -2),
					Name = 'Outline',
					Active = true,
					BorderColor3 = FromRgb(0, 0, 0),
					Position = Dim2(0, 1, 0, 1),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Outline, 'Outline', 'BackgroundColor3')
				
				local Visualize = Library:Create('Frame', {
					Parent = Outline,
					Size = Dim2(1, -2, 1, -2),
					Name = 'Visualize',
					Active = true,
					BorderColor3 = FromRgb(0, 0, 0),
					Position = Dim2(0, 1, 0, 1),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(0, 221, 255)
				});
				local UIGradient = Library:Create('UIGradient', {
					Parent = Visualize,
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(25, 25, 25))}
				});
				local SatValPicker = Library:Create('Frame', {
					Parent = MainHolderBackground,
					Name = 'SatValPicker',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -20, 1, -0.5),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(SatValPicker, 'Inline', 'BackgroundColor3')
				
				local Outline = Library:Create('Frame', {
					Parent = SatValPicker,
					Name = 'Outline',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(Outline, 'Outline', 'BackgroundColor3')
				
				local Colorpicker = Library:Create('Frame', {
					Parent = Outline,
					Name = 'Colorpicker',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(0, 221, 255)
				});
				
				local Sat = Library:Create('TextButton', {
					Parent = Colorpicker,
					Name = 'Sat',
					Size = Dim2(1, 0, 1, 0),
					BorderColor3 = FromRgb(0, 0, 0),
					ZIndex = 2,
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255),
					Text = '',
					AutoButtonColor = false,
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Sat,
					Rotation = 270,
					Transparency = NumSeq{NumKey(0, 0), NumKey(1, 1)},
					Color = ColorSeq{ColorKey(0, FromRgb(0, 0, 0)), ColorKey(1, FromRgb(0, 0, 0))}
				});
				
				local Val = Library:Create('TextButton', {
					Parent = Colorpicker,
					Name = 'Val',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255),
					Text = '',
					AutoButtonColor = false,
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Val,
					Transparency = NumSeq{NumKey(0, 0), NumKey(1, 1)}}
				);
				
				local SatValCursor = Library:Create('Frame', {
					Parent = Colorpicker,
					Name = 'SatValCursor',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 3.5, 0, 3.5),
					BorderSizePixel = 1.5,
					BackgroundColor3 = FromRgb(255, 255, 255),
					ZIndex = 3,
				});

				--

			function Cfg.SetVisible(Boolean)
				if not (ColorpickerHolder and ColorpickerButton) then return end;
				if not (Boolean) then
					Library:Tween(ColorpickerHolder, {Position = Dim2(0, ColorpickerButton.AbsolutePosition.X, ColorpickerButton.AbsolutePosition.Y)}, 0.185);
				else
					Library:Tween(ColorpickerHolder, {Position = Dim2(0, ColorpickerButton.AbsolutePosition.X, 0, ColorpickerButton.AbsolutePosition.Y)}, 0.185);
					Wait(0.185)
					Library:Tween(ColorpickerHolder, {Position = Dim2(0, ColorpickerButton.AbsolutePosition.X + 28, 0, ColorpickerButton.AbsolutePosition.Y)}, 0.185);
				end;

				ColorpickerHolder.Visible = Boolean

				if (Boolean) then
					if (Library.CurrentElementOpened and Library.CurrentElementOpened ~= Cfg) then
							Library.CurrentElementOpened.SetVisible(false)
							Library.CurrentElementOpened.Open = false 
						end;

						Library.CurrentElementOpened = Cfg
					end;
				end;

			ColorpickerButton.MouseButton1Click:Connect(function()		
				Cfg.Open = (not Cfg.Open)
				Cfg.SetVisible(Cfg.Open) 
			end)

			function Cfg.Set(Color)
				if (Color) then
				    H, s, v = Color:ToHSV()
                end;
				local HsvPosition = FromHsv(H, s, v)
				local Color = FromHsv(H, s, v)
				
				local Value = (1 - H or 1 - 0)
				local Offset = (Value < 1) and 0 or -4

				Visualize.BackgroundColor3 = Color
				Handler.BackgroundColor3 = Color 

				Colorpicker.BackgroundColor3 = FromHsv(H, 1, 1)
				
				Cfg.Color = Color
				
				local SOffset = (s < 1) and 0 or -3
				local VOffset = (1 - v < 1) and 0 or -3

				Library:Tween(HuePicker, {Position = Dim2(0, 0, Value, Offset)}, 0.045)
				Library:Tween(SatValCursor, {Position = Dim2(s, SOffset, 1 - v, VOffset)}, 0.035)
				
				Flags[Cfg.Flag] = {} 
				Flags[Cfg.Flag]['Color'] = Color
				-- Flags[Cfg.Flag]['Transparency'] = A
				Cfg.Callback(Color)
			end;


			function Cfg.UpdateColor()
				local Mouse = InputService:GetMouseLocation()
				if DraggingSat then
					s = Clamp((NewVect2(Mouse.X, Mouse.Y - GuiOffset) - Val.AbsolutePosition).X / Val.AbsoluteSize.X, 0, 1);
					v = 1 - Clamp((NewVect2(Mouse.X, Mouse.Y - GuiOffset) - Sat.AbsolutePosition).Y / Sat.AbsoluteSize.Y, 0, 1);
				elseif DraggingHue then
					H = Clamp(1 - (NewVect2(Mouse.X, Mouse.Y - GuiOffset) - Hue.AbsolutePosition).Y / Hue.AbsoluteSize.Y, 0, 1);
				end;
					Cfg.Set(nil, nil)
				end;
				
				Hue.MouseButton1Down:Connect(function()
					DraggingHue = true 
				end)

				Sat.MouseButton1Down:Connect(function()
					DraggingSat = true
				end)

				InputService.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						DraggingSat = false
						DraggingHue = false
					end;
				end)

				InputService.InputChanged:Connect(function(Input)
					if (DraggingSat or DraggingHue) and Input.UserInputType == Enum.UserInputType.MouseMovement then
						Cfg.UpdateColor() 
					end;
				end)

				Library:Connection(RunService.PostSimulation, function()
					if not (Flags[Cfg.Flag .. ' RainbowFlag']) then return end;
					Cfg.Set(FromHsv(Abs(Sin(Library.Tick)), s, v));
				end)

				Cfg.Set(Cfg.Color);
				Library.ConfigFlags[Cfg.Flag] = Cfg.Set;
		
			return Setmetatable(Cfg, Library) 
		end;

		function Library:Keybind(Options)
			local Parent = self.RightHolder

			local Cfg = {
				Flag = (Options.Flag or '(Keybind) EMPTY FLAG: '),
				Callback = Options.Callback or function() end;
				Open = false,
				Binding = nil, 
				Name = Options.Name or nil, 
				IgnoreKey = Options.ignore or false, 

				Key = Options.Key or nil, 
				Mode = Options.Mode or 'Toggle',
				Active = Options.default or false, 

				HoldInst = {},
			}

			Flags[Cfg.Flag] = {} 
			-- if not Cfg.Name then return end;
			local KeybindElement; 
				KeybindElement = Library:Create('TextLabel', {
				Parent = Library.KeybindList,
				-- Name = '',
				FontFace = Library.Font,
				TextColor3 = Themes[Library.UTheme].Text,
				BorderColor3 = FromRgb(0, 0, 0),
				Text = '[ Hold ] Fly - X',
				Size = Dim2(1, -5, 0, 18),
				Visible = false, 
				Position = Dim2(0, 5, 0, -1),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				AutomaticSize = Enum.AutomaticSize.Y,
				TextSize = 10;
				BackgroundColor3 = Themes[Library.UTheme].Text
			}, 'text')

			local ElementOutline = Library:Create('TextButton', {
				Parent = Parent,
				-- Name = '',
				BorderColor3 = FromRgb(0, 0, 0),
				Text = '', 
				Size = Dim2(0, 24, 0, 14),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundColor3 = Themes[Library.UTheme].Outline
			}) Library:ApplyTheme(ElementOutline, 'Outline', 'BackgroundColor3')

			Library:Create('UIPadding', {
				Parent = ElementOutline,
				PaddingRight = NewDim(0, 2),
			})

			local instance = Library:Hover(ElementOutline, ElementOutline)
			instance.Size = Dim2(1, 2, 1, 0)

			local Inline = Library:Create('Frame', {
				Parent = ElementOutline,
				-- Name = '',
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.X,
				Size = Dim2(1, -2, 1, -2),
				ZIndex = 2;
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Inline
			}) Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')

			Library:Create('UIPadding', {
				Parent = Inline,
				PaddingRight = NewDim(0, 2),
			})
			
			local Handler = Library:Create('Frame', {
				Parent = Inline,
				-- Name = '',
				ZIndex = 2;
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundColor3 = FromRgb(255, 255, 255)
			})

			local UIGradient = Library:Create('UIGradient', {
				Parent = Handler,
				-- Name = '',
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, Themes[Library.UTheme].LowContrast), ColorKey(1, Themes[Library.UTheme].HighContrast)}
			});
            --// Nigga
			Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
			
			local KeyText = Library:Create('TextLabel', {
				Parent = Handler,
				-- Name = '',
				FontFace = Library.Font,
				TextColor3 = Themes[Library.UTheme].Text,
				BorderColor3 = FromRgb(0, 0, 0),
				ZIndex = 2;
				Size = Dim2(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Position = Dim2(0, 0, 0, -1),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.XY,
				TextSize = 10;
				BackgroundColor3 = FromRgb(255, 255, 255)
			})

			Library:Create('UIPadding', {
				Parent = KeyText,
				PaddingLeft = NewDim(0, 3),
				PaddingRight = NewDim(0, 2),
			})
			
			--// Mode selector
				local KeybindSelector = Library:Create('Frame', {
					Parent = SGui,
					-- Name = '',
					Position = Dim2(0, ElementOutline.AbsolutePosition.X + 1, 0, ElementOutline.AbsolutePosition.Y + 17),
					BorderColor3 = FromRgb(255, 255, 255),
					BorderSizePixel = 2,
					Visible = false, 
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = FromRgb(255, 255, 255)
				})
				
				Library:Create('UIListLayout', {
					Parent = KeybindSelector,
					-- Name = '',
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = NewDim(0, 2)
				})
				
				local ButtonHold = Library:Create('TextButton', {
					Parent = KeybindSelector,
					-- Name = '',
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = 'Hold',
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.XY,
					BorderSizePixel = 0,
					ZIndex = 2,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				})
				
				Library:Create('UIStroke', {
					Parent = ButtonHold,
					-- Name = '',
					LineJoinMode = Enum.LineJoinMode.Miter
				})
				
				Library:Create('UIPadding', {
					Parent = KeybindSelector,
					-- Name = '',
					PaddingTop = NewDim(0, 3),
					PaddingBottom = NewDim(0, 5),
					PaddingRight = NewDim(0, 5),
					PaddingLeft = NewDim(0, 5)
				})
				
				local ButtonToggle = Library:Create('TextButton', {
					Parent = KeybindSelector,
					-- Name = '',
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = 'Toggle',
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.XY,
					BorderSizePixel = 0,
					ZIndex = 2,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				})
				
				Library:Create('UIStroke', {
					Parent = ButtonToggle,
					-- Name = '',
					LineJoinMode = Enum.LineJoinMode.Miter
				})
				
				local ButtonAlways = Library:Create('TextButton', {
					Parent = KeybindSelector,
					-- Name = '',
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = 'Always',
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.XY,
					BorderSizePixel = 0,
					ZIndex = 2,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				})
				
				Library:Create('UIStroke', {
					Parent = ButtonAlways,
					-- Name = '',
					LineJoinMode = Enum.LineJoinMode.Miter
				})
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = KeybindSelector,
					-- Name = '',
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				local UIStroke = Library:Create('UIStroke', {
					Parent = KeybindSelector,
					-- Name = '',
					Color = Themes[Library.UTheme].Inline,
					LineJoinMode = Enum.LineJoinMode.Miter,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				})
			--// 

			--// init 
			function Cfg.SetVisible(Bool)
				KeybindSelector.Visible = Bool
				KeybindSelector.Position = Dim2(0, ElementOutline.AbsolutePosition.X + 1, 0, ElementOutline.AbsolutePosition.Y + 17)

				if Bool then 
					if Library.CurrentElementOpen and Library.CurrentElementOpen ~= Cfg then 
						Library.CurrentElementOpen.SetVisible(false)
						Library.CurrentElementOpen.Open = false 
					end;

					Library.CurrentElementOpen = Cfg 
				end;
			end;

			function Cfg.SetMode(Mode) 
				Cfg.Mode = Mode 

				if Mode == 'Always' then
					Cfg.Set(true)
				elseif Mode == 'Hold' then
					Cfg.Set(false)
				end;

				Flags[Cfg.Flag]['Mode'] = Mode
			end;

			function Cfg.Set(Input)
				if type(Input) == 'boolean' then 
					local __cached = Input 

					if Cfg.Mode == 'Always' then 
						__cached = true 
					end;

					Cfg.Active = __cached 
					Flags[Cfg.Flag]['Active'] = __cached 
					Cfg.Callback(__cached)
				elseif (Tostring(Input):find('Enum')) then
					Input = (Input.Name == 'Escape' and 'None' or Input)
					Cfg.Key = (Input or 'None')

					local _text = (Keys[Cfg.Key] or Tostring(Cfg.Key):gsub('Enum.', ''))
					local _text2 = (Tostring(_text):gsub('KeyCode.', ''):gsub('UserInputType.', '') or 'None')
					Cfg.KeyName = _text2

					Flags[Cfg.Flag]['Mode'] = Cfg.Mode 
					Flags[Cfg.Flag]['Key'] = Cfg.Key 
						
					KeyText.Text = (_text2)

					Cfg.Callback(Cfg.Active or false)
				elseif FindTable({'Toggle', 'Hold', 'Always'}, Input) then 
					Cfg.SetMode(Input)

					if Input == 'Always' then 
						Cfg.Active = true 
					end; 

					Cfg.Callback(Cfg.Active or false)
				elseif type(Input) == 'table' then 
					Input.Key = (type(Input.Key) == 'string' and Input.Key ~= 'None' and Library:ConvertEnum(Input.Key) or Input.Key)

					Input.Key = (Input.Key == Enum.KeyCode.Escape and 'None' or Input.Key)
					Cfg.Key = (Input.Key or 'None')

					Cfg.Mode = Input.Mode or 'Toggle'

					if Input.Active then
						Cfg.Active = Input.Active
					end;

					local text = Tostring(Cfg.Key) ~= 'Enums' and (Keys[Cfg.Key] or Tostring(Cfg.Key):gsub('Enum.', '')) or nil
					local __text = text and (Tostring(text):gsub('KeyCode.', ''):gsub('UserInputType.', ''))
						KeyText.Text = (__text)
					Cfg.KeyName = __text
				end;

				Flags[Cfg.Flag] = {
					Mode = Cfg.Mode,
					Key = Cfg.Key, 
					Active = Cfg.Active
				};
					
				if Cfg.Name then 
					KeybindElement.Visible = Cfg.Active

					Library:Tween(KeybindElement, {TextTransparency = Cfg.Active and 0 or 1}, 0.185) 
					Library:Tween(KeybindElement:FindFirstChildOfClass('UIStroke'), {Transparency = Cfg.Active and 0 or 1}, 0.185) 

					local text = Tostring(Cfg.Key) ~= 'Enums' and (Keys[Cfg.Key] or Tostring(Cfg.Key):gsub('Enum.', '')) or nil
					local __text = text and (Tostring(text):gsub('KeyCode.', ''):gsub('UserInputType.', ''))

					if Cfg.Name then 
						KeybindElement.Text = '[' .. string.upper(SubString(Cfg.Mode, 1, 1)) .. SubString(Cfg.Mode, 2) .. '] ' .. Cfg.Name .. ' - ' .. __text
					end;
				end;
			end;

			ButtonHold.MouseButton1Click:Connect(function()
				Cfg.SetMode('Hold')
				Cfg.SetVisible(false)
				Cfg.Open = false
			end)

			ButtonToggle.MouseButton1Click:Connect(function()
				Cfg.SetMode('Toggle')
				Cfg.SetVisible(false)
				Cfg.Open = false
			end)

			ButtonAlways.MouseButton1Click:Connect(function()
				Cfg.SetMode('Always')
				Cfg.SetVisible(false)
				Cfg.Open = false 
			end)

			ElementOutline.MouseButton2Click:Connect(function()
				Cfg.Open = not Cfg.Open;
				Cfg.SetVisible(Cfg.Open)
			end)

			ElementOutline.MouseButton1Down:Connect(function()
				KeyText.Text = '...'

				Cfg.Binding = Library:Connection(InputService.InputBegan, function(Input, GameEvent)
					local SelectedKey = Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode or Input.UserInputType
					if SelectedKey == Enum.UserInputType.MouseButton1 then return end;
					Cfg.Set(SelectedKey)

					Cfg.Binding:Disconnect() 
					Cfg.Binding = nil
				end)
			end)

			Library:Connection(InputService.InputBegan, function(Input, GameEvent) 
				local SelectedKey = Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode or Input.UserInputType

				if not GameEvent then 
					if SelectedKey == Cfg.Key then 
						if Cfg.Mode == 'Toggle' then 
							Cfg.Active = not Cfg.Active
							Cfg.Set(Cfg.Active)
						elseif Cfg.Mode == 'Hold' then 
							Cfg.Set(true)
						end;
					end;
				end;
			end)

			Library:Connection(InputService.InputEnded, function(Input, GameEvent) 
				if GameEvent then 
					return 
				end;

				local SelectedKey = Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode or Input.UserInputType
		
				if SelectedKey == Cfg.Key then
					if Cfg.Mode == 'Hold' then 
						Cfg.Set(false)
					end;
				end;
			end)
		
			Cfg.Set({Mode = Cfg.Mode, Active = Cfg.Active, Key = Cfg.Key})
		
			Library.ConfigFlags[Cfg.Flag] = Cfg.Set

			return setmetatable(Cfg, Library)
		end;

		function Library:Dropdown(Options)
			local Parent = self.Holder 

			local Cfg = {
				Name = Options.Name or nil,
				Flag = (Options.Flag or '(Dropdown) EMPTY FLAG: '),
				Items = Options.Items or {'1', '2', '3'},
				Callback = Options.Callback or function() end;
				Multi = Options.Multi or false, 
				Visible = Options.Visible or true,
				Open = false, 
				OptionInstances = {}, 
				MultiItems = {}, 
				Scrolling = Options.Scrolling or false, 
				Ignore = Options.Ignore or nil,
			}

			Cfg.Default = Options.Default or (Cfg.Multi and {Cfg.Items[1]}) or Cfg.Items[1] or nil

			--// Dropdown Elements
				local RealDropdown = Library:Create('TextLabel', {
					Parent = Parent,
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '',
					Name = 'Dropdown',
					ZIndex = 2,
					Size = Dim2(1, -8, 0, 12),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});

				local MainText
				if Cfg.Name then
					local LeftComponents = Library:Create('Frame', {
						Parent = RealDropdown,
						Name = 'LeftComponents',
						BackgroundTransparency = 1,
						Position = Dim2(0, 2, 0, -1),
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(0, 0, 0, 14),
						BorderSizePixel = 0,
						BackgroundColor3 = FromRgb(255, 255, 255)
					});

					MainText = Library:Create('TextLabel', {
						Parent = LeftComponents,
						FontFace = Library.Font,
						TextColor3 = Themes[Library.UTheme].Text,
						BorderColor3 = FromRgb(0, 0, 0),
						Text = Cfg.Name,
						Name = 'Text',
						BackgroundTransparency = 1,
						Size = Dim2(0, 0, 1, -1),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.X,
						TextSize = 10;
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					
					Library:Create('UIStroke', {
						Parent = MainText,
						LineJoinMode = Enum.LineJoinMode.Miter
					});
					
					Library:Create('UIListLayout', {
						Parent = LeftComponents,
						Padding = NewDim(0, 5),
						-- Name = '',
						FillDirection = Enum.FillDirection.Horizontal
					});

					local RightComponents = Library:Create('Frame', {
						Parent = RealDropdown,
						Name = 'RightComponents',
						Position = Dim2(1, -1, 0, 1),
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(0, 0, 0, 12),
						BorderSizePixel = 0,
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					Cfg['RightHolder'] = RightComponents
		
					local List = Library:Create('UIListLayout', {
						Parent = RightComponents,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = NewDim(0, 4),
						Name = 'List',
						SortOrder = Enum.SortOrder.LayoutOrder
					});
				end;

				local BottomComponents = Library:Create('Frame', {
					Parent = RealDropdown,
					Name = 'BottomComponents',
					Position = Dim2(0, 0, 0, Cfg.Name and 15 or 0),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 26, 0, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local Dropdown = Library:Create('TextButton', {
					Parent = BottomComponents,
					Name = 'Dropdown',
					Position = Dim2(0, 0, 0, 2),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -27, 1, 18),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline,
					Text = '',
					AutoButtonColor = false, 
				});
				Library:ApplyTheme(Dropdown, 'Outline', 'BackgroundColor3')
				
				Library:Hover(RealDropdown, Dropdown)

				local Inline = Library:Create('Frame', {
					Parent = Dropdown,
					Name = 'Inline',
					ZIndex = 2;
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')
				
				local Background = Library:Create('Frame', {
					Parent = Inline,
					Name = 'Background',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					ZIndex = 2;
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Accent
				});
				Library:ApplyTheme(Background, 'Accent', 'BackgroundColor3')
				
				local Contrast = Library:Create('Frame', {
					Parent = Background,
					Name = 'Contrast',
					ZIndex = 2;
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});

				local Plus = Library:Create('TextLabel', {
					Parent = Contrast,
					TextWrapped = true,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					ZIndex = 2;
					Text = '+',
					Name = 'Plus',
					Size = Dim2(1, -4, 1, 0),
					Position = Dim2(0, 0, 0, -1),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Right,
					FontFace = Library.Font,
					TextTruncate = Enum.TextTruncate.AtEnd,
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				Library:Create('UIStroke', {
					Parent = Plus,
					LineJoinMode = Enum.LineJoinMode.Miter
				});
				
				local Text = Library:Create('TextLabel', {
					Parent = Contrast,
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					ZIndex = 2;
					BorderColor3 = FromRgb(0, 0, 0),
					Text = 'aa',
					Name = 'Text',
					Size = Dim2(1, -4, 1, 0),
					Position = Dim2(0, 4, 0, -1),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				Library:Create('UIStroke', {
					Parent = Text,
					LineJoinMode = Enum.LineJoinMode.Miter
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Contrast,
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Background,
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(167, 167, 167))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				Library:Create('UIListLayout', {
					Parent = BottomComponents,
					Padding = NewDim(0, 10),
					-- Name = '',
					SortOrder = Enum.SortOrder.LayoutOrder
				});
			--

			--// Dropdown Holder
				local DropdownHolder = Library:Create('Frame', {
					Parent = SGui,
					BorderColor3 = FromRgb(0, 0, 0),
					Name = 'DropdownHolder',
					BackgroundTransparency = 1,
					Position = Dim2(0, Dropdown.AbsolutePosition.X + 1, 0, Dropdown.AbsolutePosition.Y + 22),
					Size = Dim2(0, Dropdown.AbsoluteSize.X, 0, Cfg.Scrolling and 180 or 0),
					BorderSizePixel = 0,
					AutomaticSize = Cfg.Scrolling and Enum.AutomaticSize.None or Enum.AutomaticSize.Y,
					BackgroundColor3 = Themes[Library.UTheme].Outline,
					Visible = false
				});
				
				local Inline = Library:Create('Frame', {
					Parent = DropdownHolder,
					Size = Dim2(1, -2, 1, 2),
					Name = 'Inline',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					ZIndex = 2,
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')
				
				local Background;
				if not Cfg.Scrolling then
					Background = Library:Create('Frame', {
						Parent = Inline,
						BorderColor3 = FromRgb(0, 0, 0),
						Name = 'Background',
						BackgroundTransparency = 1,
						Position = Dim2(0, 1, 0, 1),
						Size = Dim2(1, -2, 1, 1),
						ZIndex = 2,
						BorderSizePixel = 0,
						BackgroundColor3 = Themes[Library.UTheme].Accent
					});
					Library:ApplyTheme(Background, 'Accent', 'BackgroundColor3')
				else 
					Background = Library:Create('ScrollingFrame', {
						Parent = Inline,
						BorderColor3 = FromRgb(0, 0, 0),
						Name = 'Background',
						BackgroundTransparency = 1,
						MidImage = getcustomasset(Library.Directory.. '/Assets/Images/White.Png'),
						TopImage = MidImage,
						BottomImage = MidImage,
						Position = Dim2(0, 1, 0, 1),
						Size = Dim2(1, -2, 1, 1),
						ZIndex = 2,
						BorderSizePixel = 0,
						BackgroundColor3 = Themes[Library.UTheme].Accent,
						CanvasSize = Dim2(0, 0, 0, 0),
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						ScrollBarThickness = 2,
						ScrollBarImageColor3 = Themes[Library.UTheme].Accent
					});
					Library:ApplyTheme(Background, 'Accent', 'BackgroundColor3')
					Library:ApplyTheme(Background, 'Accent', 'ScrollBarImageColor3')
				end;
				
				local Contrast = Library:Create('Frame', {
					Parent = Background,
					Name = 'Contrast',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 0, 1, -3),
					BorderSizePixel = 0,
					ZIndex = 2, 
					BackgroundColor3 = FromRgb(255, 255, 255),
					AutomaticSize = Cfg.Scrolling and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
				});

				Library:Create('UIPadding', {
					Parent = Contrast,
					PaddingTop = NewDim(0, 2),
					PaddingBottom = NewDim(0, 2),
					PaddingRight = NewDim(0, 0),
					PaddingLeft = NewDim(0, 4)
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Contrast,
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(41, 255, 55)), ColorKey(1, FromRgb(35, 35, 47))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
			
				Library:Create('UIListLayout', {
					Parent = Contrast,
					Padding = NewDim(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Background,
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(167, 167, 167))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				local Stroke = Library:Create('UIStroke', {
					Parent = Inline,
					Color = Themes[Library.UTheme].Outline,
					LineJoinMode = Enum.LineJoinMode.Miter
				});
				Library:ApplyTheme(Stroke, 'Outline', 'Color')
			--// 
				
			function Cfg.SetElementVisible(Boolean)
				RealDropdown.Visible = Boolean 
				if MainText then
					MainText.Visible = Boolean
				end;
			end;

			function Cfg.SetVisible(Boolean) 
				Library.CurrentElementOpened = Cfg.Ignore or Cfg

				local Old = Dropdown.AbsolutePosition.Y + 20
				Library:Tween(DropdownHolder, {Size = Dim2(0, Dropdown.AbsoluteSize.X, 0, DropdownHolder.Size.Y.Offset)}, 0.185)
				Library:Tween(DropdownHolder, {Position = Dim2(0, Dropdown.AbsolutePosition.X, 0, Dropdown.AbsolutePosition.Y)}, 0.185)
				Wait(0.185)
				Library:Tween(DropdownHolder, {Position = Dim2(0, Dropdown.AbsolutePosition.X, 0, Old)}, 0.185)

				DropdownHolder.Visible = Boolean
				Plus.Text = (Boolean and '-' or '+')
				Plus.TextSize = (Boolean and 10 or 8)

				if Boolean then
					if (Library.CurrentElementOpened and Library.CurrentElementOpened ~= Cfg) then
						Library.CurrentElementOpened.SetVisible(false)
						Library.CurrentElementOpened.Open = false
					end;
 
					--// DropdownHolder.Size = Dim2(0, Dropdown.AbsoluteSize.X, 0, DropdownHolder.Size.Y.Offset)
					--// DropdownHolder.Position = Dim2(0, Dropdown.AbsolutePosition.X + 1, 0, Dropdown.AbsolutePosition.Y + 22)					
				end;
			end;

			function Cfg.Set(Value) 
				local Selected = {}

				local IsTable = type(Value) == 'table'

				for _, v in next, Cfg.OptionInstances do 
					if v.Text == Value or (IsTable and FindTable(Value, v.Text)) then
						InsertTable(Selected, v.Text)
						Cfg.MultiItems = Selected
						v.TextColor3 = Themes[Library.UTheme].Accent
					else 
						v.TextColor3 = Themes[Library.UTheme].Text
					end;
				end;

				Text.Text = IsTable and ConcatTable(Selected, ', ') or Selected[1] or 'None'
				Flags[Cfg.Flag] = IsTable and Selected or Selected[1]
				Cfg.Callback(Flags[Cfg.Flag]) 
			end;
			
			function Cfg:RefreshOptions(RefreshedList) 
				for _, v in next, Cfg.OptionInstances do 
					v:Destroy() 
				end;

				Cfg.OptionInstances = {} 

				for i,v in next, RefreshedList do 
					local TextButton = Library:Create('TextButton', {
						Parent = Contrast,
						FontFace = Library.Font,
						TextColor3 = Themes[Library.UTheme].Text,
						BorderColor3 = FromRgb(0, 0, 0),
						Size = Dim2(1, 0, 0, 0),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						TextWrapped = true,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = 10;
						TextXAlignment = Enum.TextXAlignment.Left,
						ZIndex = 2, 
						Text = v,
						BackgroundColor3 = FromRgb(255, 255, 255)
					});
					Library:ApplyTheme(TextButton, 'Accent', 'TextColor3')
					
					Library:Create('UIStroke', {
						Parent = TextButton,
						LineJoinMode = Enum.LineJoinMode.Miter
					});

					InsertTable(Cfg.OptionInstances, TextButton)

					TextButton.MouseButton1Down:Connect(function()
						if Cfg.Multi then
							local SelectedIndex = FindTable(Cfg.MultiItems, TextButton.Text)

							if SelectedIndex then
								RemoveTable(Cfg.MultiItems, SelectedIndex)
							else
								InsertTable(Cfg.MultiItems, TextButton.Text)
							end;

							Cfg.Set(Cfg.MultiItems) 				
						else 
							Cfg.SetVisible(false)
							Cfg.Open = false 

							Cfg.Set(TextButton.Text)
						end;
					end)
				end;
			end;

			Dropdown.MouseButton1Click:Connect(function()
				Cfg.Open = not Cfg.Open 

				Cfg.SetVisible(Cfg.Open)
			end)

			Cfg:RefreshOptions(Cfg.Items) 

			Cfg.Set(Cfg.Default)
			
			Library.ConfigFlags[Cfg.Flag] = Cfg.Set
			Library.VisibleFlags[Cfg.Flag] = Cfg.SetElementVisible

			Cfg.SetElementVisible(Cfg.Visible)

			return Setmetatable(Cfg, Library)
		end;

		function Library:List(Options)
			local Cfg = {
				Callback = (Options and Options.Callback or function() end),
				Scale = Options.Size or 232, 
				Items = Options.Items or {'1', '2', '3'}, 
				--// Order = Options.Order or 1, 
				PlaceholderText = Options.PlaceHolder or Options.PlaceholderText or 'Search here...',
				Visible = Options.Visible or true,
				OptionInstances = {}, 
				CurrentInstance = nil, 
				Flag = (Options.Flag or '(List) EMPTY FLAG: '),
			} 

			--// Instances 
				local ListHolder = Library:Create('TextLabel', {
					Parent = self.Holder,
					-- Name = '',
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '',
					ZIndex = 2,
					Size = Dim2(1, -8, 0, 12),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local UIPadding = Library:Create('UIPadding', {
					Parent = ListHolder,
					-- Name = '',
					PaddingLeft = NewDim(0, 1)
				});
				
				local UIStroke = Library:Create('UIStroke', {
					Parent = ListHolder,
					Name = ''
				});
				
				local BottomComponents = Library:Create('Frame', {
					Parent = ListHolder,
					-- Name = '',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 26, 0, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				Library:Create('UIListLayout', {
					Parent = BottomComponents,
					-- Name = '',
					Padding = NewDim(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder
				});
				
				local List = Library:Create('Frame', {
					Parent = BottomComponents,
					-- Name = '',
					Position = Dim2(0, 0, 0, 2),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -27, 1, Cfg.Scale),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(MainHolder, 'Outline', 'BackgroundColor3')
				
				local Inline = Library:Create('Frame', {
					Parent = List,
					-- Name = '',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')
				
				local Background = Library:Create('Frame', {
					Parent = Inline,
					-- Name = '',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Accent
				});
				Library:ApplyTheme(Background, 'Accent', 'BackgroundColor3')
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Background,
					-- Name = '',
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(167, 167, 167))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				local Contrast = Library:Create('Frame', {
					Parent = Background,
					-- Name = '',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Contrast,
					-- Name = '',
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				local ScrollingFrame = Library:Create('ScrollingFrame', {
					Parent = Contrast,
					-- Name = '',
					ScrollBarImageColor3 = Themes[Library.UTheme].Accent,
					Active = true,
					MidImage = getcustomasset(Library.Directory.. '/Assets/Images/White.Png'),
					TopImage = MidImage,
					BottomImage = MidImage,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollBarThickness = 2,
					BackgroundTransparency = 1,
					Size = Dim2(1, 0, 1, 0),
					BackgroundColor3 = FromRgb(255, 255, 255),
					BorderColor3 = FromRgb(0, 0, 0),
					BorderSizePixel = 0,
					CanvasSize = Dim2(0, 0, 0, 0)
				});
				Library:ApplyTheme(ScrollingFrame, 'Accent', 'ScrollBarImageColor3')
				
				local UIPadding = Library:Create('UIPadding', {
					Parent = ScrollingFrame,
					-- Name = '',
					PaddingBottom = NewDim(0, 4),
					PaddingTop = NewDim(0, 4)
				});
				
				local UIListLayout = Library:Create('UIListLayout', {
					Parent = ScrollingFrame,
					-- Name = '',
					Padding = NewDim(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder
				});
			--//

			function Cfg.RenderOption(Text) 
				local TextButton = Library:Create('TextButton', {
					Parent = ScrollingFrame,
					-- Name = '',
					Text = Tostring(Text),
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					BackgroundTransparency = 1,
					Size = Dim2(1, 0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});

				Library:ApplyTheme(TextButton, 'Accent', 'TextColor3')

				local UIStroke = Library:Create('UIStroke', {
					Parent = TextButton,
					Name = ''
				});

				return TextButton 
			end;

			function Cfg.SetElementVisible(Boolean)
				ListHolder.Visible = Boolean 
			end;

			function Cfg.RefreshOptions(Options) 
				if type(Options) == 'function' then
					return 
				end;

				for _, v in next, Cfg.OptionInstances do 
					v:Destroy() 
				end;

				for _, Option in next, Options do 
					local Button = Cfg.RenderOption(Option) 

					InsertTable(Cfg.OptionInstances, Button)

					Button.MouseButton1Click:Connect(function()
						if (Cfg.CurrentInstance and Cfg.CurrentInstance ~= Button) then
							Cfg.CurrentInstance.TextColor3 = Themes[Library.UTheme].Text 
						end;

						Cfg.CurrentInstance = Button 
						Button.TextColor3 = Themes[Library.UTheme].Accent 

						Flags[Cfg.Flag] = Button.Text
						
						Cfg.Callback(Button.Text)
					end)
				end;
			end;

			function Cfg.FilterOptions(Text)
				for _, v in next, Cfg.OptionInstances do 
					if string.find(v.Text, Text) then
						v.Visible = true 
					else 
						v.Visible = false
					end;
				end;
			end;

			function Cfg.Set(Value)
				for _, Buttons in next, Cfg.OptionInstances do 
					if Buttons.Text == Value then
						Buttons.TextColor3 = Themes[Library.UTheme].Accent 
					else 
						Buttons.TextColor3 = Themes[Library.UTheme].Text 
					end;
				end;

				Flags[Cfg.Flag] = Value
				Cfg.Callback(Value)
			end;

			Cfg.RefreshOptions(Cfg.Items) 
			Cfg.SetElementVisible(Cfg.Visible)

			Library.VisibleFlags[Cfg.Flag] = Cfg.SetElementVisible
			Library.ConfigFlags[Cfg.Flag] = Cfg.Set

			return Setmetatable(Cfg, Library)
		end;

		function Library:Textbox(Options)
			local Cfg = {
				PlaceHolder = Options.PlaceHolder or Options.PlaceHolderText or Options.Holder or Options.Holdertext or 'type here...',
				Default = Options.Default,
				Flag = (Options.Flag or '(Textbox) EMPTY FLAG: '),
				Callback = Options.Callback or function() end;
				Visible = Options.Visible or true,
			}
			
			--// Instances 
				local TextboxHolder = Library:Create('TextLabel', {
					Parent = self.Holder,
					-- Name = '',
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '',
					ZIndex = 2,
					Size = Dim2(1, -8, 0, 12),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				Library:Create('UIPadding', {
					Parent = TextboxHolder,
					-- Name = '',
					PaddingLeft = NewDim(0, 1)
				});
				
				Library:Create('UIStroke', {
					Parent = TextboxHolder,
					Name = ''
				});
				
				local Button = Library:Create('Frame', {
					Parent = TextboxHolder,
					-- Name = '',
					Position = Dim2(0, 0, 0, 2),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -27, 0, 18),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:Hover(TextboxHolder, Button)
				
				Library:ApplyTheme(Button, 'Outline', 'BackgroundColor3')
				
				local Inline = Library:Create('Frame', {
					Parent = Button,
					-- Name = '',
					Position = Dim2(0, 1, 0, 1),
					ZIndex = 2;
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				
				Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')
				
				local Background = Library:Create('Frame', {
					Parent = Inline,
					-- Name = '',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					ZIndex = 2;
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Accent
				});
				
				Library:ApplyTheme(Background, 'Accent', 'BackgroundColor3')
				
				local TextBox = Library:Create('TextBox', {
					Parent = Background,
					-- Name = '',
					CursorPosition = -1,
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '', 
					Size = Dim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					TextWrapped = true,
					BackgroundTransparency = 1,
					TextTruncate = Enum.TextTruncate.SplitWord,
					PlaceholderText = 'Type here...',
					ClearTextOnFocus = false,
					ZIndex = 3;
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				Library:Create('UIStroke', {
					Parent = TextBox,
					Name = ''
				});
				
				local TextButton = Library:Create('TextButton', {
					Parent = Background,
					-- Name = '',
					FontFace = Library.Font,
					TextColor3 = FromRgb(0, 0, 0),
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '',
					AutoButtonColor = false,
					Size = Dim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					TextSize = 10;
					ZIndex = 2;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = TextButton,
					-- Name = '',
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
				});
				
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				Library:Create('UIListLayout', {
					Parent = TextboxHolder,
					-- Name = '',
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = NewDim(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder
				});
					
				TextBox:GetPropertyChangedSignal('Text'):Connect(function()
					Flags[Cfg.Flag] = TextBox.Text
					Cfg.Callback(TextBox.Text)
				end)
			--// 

			function Cfg.SetElementVisible(Boolean)
				TextboxHolder.Visible = Boolean 
			end;

			function Cfg.Set(Text) 
				Flags[Cfg.Flag] = Text
				TextBox.Text = Text
				Cfg.Callback(Text)
			end;

			if Cfg.Default then
				Cfg.Set(Cfg.Default) 
			end;

			Cfg.SetElementVisible(Cfg.Visible)

			Library.ConfigFlags[Cfg.Flag] = Cfg.Set
			Library.VisibleFlags[Cfg.Flag] = Cfg.SetElementVisible

			return Setmetatable(Cfg, Library) 
		end;

		function Library:ButtonHolder(Options) 
			local Cfg = {
				Flag = (Options.Flag or '(ButtonHolder) EMPTY FLAG: '),
				Visible = Options.Visible or true,
			}

			local ButtonHolder = Library:Create('TextLabel', {
				Parent = self.Holder,
				-- Name = '',
				FontFace = Library.Font,
				TextColor3 = Themes[Library.UTheme].Text,
				BorderColor3 = FromRgb(0, 0, 0),
				Text = '',
				ZIndex = 2,
				Size = Dim2(1, -8, 0, 12),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				AutomaticSize = Enum.AutomaticSize.Y,
				TextYAlignment = Enum.TextYAlignment.Top,
				TextSize = 10;
				BackgroundColor3 = FromRgb(255, 255, 255), 
			});

			self.CurrentHolder = ButtonHolder

			--// Instances 
				Library:Create('UIStroke', {
					Parent = ButtonHolder,
					Name = ''
				});
				
				Library:Create('UIListLayout', {
					Parent = ButtonHolder,
					-- Name = '',
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = NewDim(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder
				});
			--// 
			
			function Cfg.SetElementVisible(Boolean)
				ButtonHolder.Visible = Boolean 
			end;

			Cfg.SetElementVisible(Cfg.Visible)

			Library.VisibleFlags[Cfg.Flag] = Cfg.SetElementVisible

			return Setmetatable(Cfg, Library)
		end;

		function Library:Button(Options)
			local Cfg = {
				Callback = Options.Callback or function() end; 
				Name = Options.Text or Options.Name or 'Button',
			}

			local Button = Library:Create('TextButton', {
				Parent = self.CurrentHolder,
				-- Name = '',
				Position = Dim2(0, 0, 0, 2),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -27, 0, 18),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Outline,
				Text = ''
			});

			Library:Hover(Button, Button)
			
			Library:ApplyTheme(Button, 'Outline', 'BackgroundColor3')
			
			local Inline = Library:Create('Frame', {
				Parent = Button,
				-- Name = '',
				ZIndex = 2;
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Inline
			});
			
			Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')
			
			local Background = Library:Create('Frame', {
				Parent = Inline,
				-- Name = '',
				ZIndex = 2;
				Position = Dim2(0, 1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = Themes[Library.UTheme].Accent
			});
			
			Library:ApplyTheme(Background, 'Accent', 'BackgroundColor3')
			
			local _UIGradient = Library:Create('UIGradient', {
				Parent = Background,
				-- Name = '',
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(167, 167, 167))}
			});
			
			Library:ApplyTheme(_UIGradient, 'Contrast', 'Color')
			
			local Contrast = Library:Create('Frame', {
				Parent = Background,
				-- Name = '',
				ZIndex = 2;
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			
			local UIGradient = Library:Create('UIGradient', {
				Parent = Contrast,
				-- Name = '',
				Rotation = 90,
				Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
			});
			
			Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
			
			local Text = Library:Create('TextLabel', {
				Parent = Contrast,
				-- Name = '',
				TextWrapped = true,
				ZIndex = 2;
				TextColor3 = Themes[Library.UTheme].Text,
				BorderColor3 = FromRgb(0, 0, 0),
				Text = Cfg.Name,
				Size = Dim2(1, -4, 1, 0),
				Position = Dim2(0, 4, 0, -1),
				BackgroundTransparency = 1,
				TextTruncate = Enum.TextTruncate.AtEnd,
				BorderSizePixel = 0,
				FontFace = Library.Font,
				TextSize = 10;
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			
			local UIStroke = Library:Create('UIStroke', {
				Parent = Text,
				-- Name = '',
				LineJoinMode = Enum.LineJoinMode.Miter
			});

			Button.MouseButton1Click:Connect(function()
				Cfg.Callback() 
			end)

			return Setmetatable(Cfg, Library)
		end;

		function Library:Label(Options)
			local Cfg = {Name = Options.Text or Options.Name or 'Label'}

			local Dropdown = Library:Create('TextLabel', {
				Parent = self.Holder,
				-- Name = '',
				FontFace = Library.Font,
				TextColor3 = Themes[Library.UTheme].Text,
				BorderColor3 = FromRgb(0, 0, 0),
				Text = '',
				ZIndex = 2,
				Size = Dim2(1, -8, 0, 12),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				AutomaticSize = Enum.AutomaticSize.Y,
				TextYAlignment = Enum.TextYAlignment.Top,
				TextSize = 10;
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			
			local UIStroke = Library:Create('UIStroke', {
				Parent = Dropdown,
				Name = ''
			});
			
			local LeftComponents = Library:Create('Frame', {
				Parent = Dropdown,
				-- Name = '',
				BackgroundTransparency = 1,
				Position = Dim2(0, 2, 0, -1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(0, 0, 0, 14),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			
			local TextLabel = Library:Create('TextLabel', {
				Parent = LeftComponents,
				-- Name = '',
				FontFace = Library.Font,
				TextColor3 = Themes[Library.UTheme].Text,
				BorderColor3 = FromRgb(0, 0, 0),
				Text = Cfg.Name,
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				TextSize = 10;
				BackgroundColor3 = FromRgb(255, 255, 255)
			});

			local RightComponents = Library:Create('Frame', {
				Parent = Dropdown,
				Name = 'RightComponents',
				Position = Dim2(1, -1, 0, 1),
				BorderColor3 = FromRgb(0, 0, 0),
				Size = Dim2(0, 0, 0, 12),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRgb(255, 255, 255)
			});
			Cfg.RightHolder = RightComponents

			local List = Library:Create('UIListLayout', {
				Parent = RightComponents,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				Padding = NewDim(0, 4),
				Name = 'List',
				SortOrder = Enum.SortOrder.LayoutOrder
			});
			
			local UIStroke = Library:Create('UIStroke', {
				Parent = TextLabel,
				Name = ''
			});

			function Cfg.Set(Text) 
				TextLabel.Text = Text 
			end;
						
			return Setmetatable(Cfg, Library)
		end;
		
		function Library:Playerlist(Options) 
			local Cfg = {
				Callback = Options.Callback or function() end;
				Labels = {Name, Display, Uid}
			};

			local Patterns = {
				['Priority'] = FromRgb(255, 255, 0),
				['Enemy'] = FromRgb(255, 0, 0),
				['Neutral'] = Themes[Library.UTheme].Text,
				['Friendly'] = FromRgb(0, 255, 255)
			};

			--// Elements 
				local PlayerlistHolder = Library:Create('TextLabel', {
					Parent = self.Holder,
					-- Name = '',
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '',
					ZIndex = 2,
					Size = Dim2(1, -8, 0, 12),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});

				local UIPadding = Library:Create('UIPadding', {
					Parent = PlayerlistHolder,
					-- Name = '',
					PaddingBottom = NewDim(0, -2),
					PaddingLeft = NewDim(0, 1)
				});
				
				local UIStroke = Library:Create('UIStroke', {
					Parent = PlayerlistHolder,
					Name = ''
				});
				
				local BottomComponents = Library:Create('Frame', {
					Parent = PlayerlistHolder,
					-- Name = '',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 26, 0, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				Library:Create('UIListLayout', {
					Parent = BottomComponents,
					-- Name = '',
					Padding = NewDim(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder
				});
				
				local List = Library:Create('Frame', {
					Parent = BottomComponents,
					-- Name = '',
					Position = Dim2(0, 0, 0, 2),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -27, 1, 232),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(List, 'Outline', 'BackgroundColor3')
				
				local Inline = Library:Create('Frame', {
					Parent = List,
					-- Name = '',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Inline
				});
				Library:ApplyTheme(Inline, 'Inline', 'BackgroundColor3')
				
				local Background = Library:Create('Frame', {
					Parent = Inline,
					-- Name = '',
					Position = Dim2(0, 1, 0, 1),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Accent
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Background,
					-- Name = '',
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(255, 255, 255)), ColorKey(1, FromRgb(167, 167, 167))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				local Contrast = Library:Create('Frame', {
					Parent = Background,
					-- Name = '',
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				
				local UIGradient = Library:Create('UIGradient', {
					Parent = Contrast,
					-- Name = '',
					Rotation = 90,
					Color = ColorSeq{ColorKey(0, FromRgb(41, 41, 55)), ColorKey(1, FromRgb(35, 35, 47))}
				});
				Library:ApplyTheme(UIGradient, 'Contrast', 'Color')
				
				local ScrollingFrame = Library:Create('ScrollingFrame', {
					Parent = Contrast,
					-- Name = '',
					ScrollBarImageColor3 = Themes[Library.UTheme].Accent,
					Active = true,
					MidImage = getcustomasset(Library.Directory.. '/Assets/Images/White.Png'),
					TopImage = MidImage,
					BottomImage = MidImage,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollBarThickness = 2,
					BackgroundTransparency = 1,
					Size = Dim2(1, 0, 1, 0),
					BackgroundColor3 = FromRgb(255, 255, 255),
					BorderColor3 = FromRgb(0, 0, 0),
					BorderSizePixel = 0,
					CanvasSize = Dim2(0, 0, 0, 0)
				});
				Library:ApplyTheme(ScrollingFrame, 'Accent', 'ScrollBarImageColor3')
				
				local UIPadding = Library:Create('UIPadding', {
					Parent = ScrollingFrame,
					-- Name = '',
					PaddingTop = NewDim(0, 4),
					PaddingBottom = NewDim(0, 4),
					PaddingRight = NewDim(0, 4),
					PaddingLeft = NewDim(0, 4)
				});
				
				local UIListLayout = Library:Create('UIListLayout', {
					Parent = ScrollingFrame,
					-- Name = '',
					Padding = NewDim(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder
				});
			--// 

			function Cfg.CreatePlayer(Player) 
				Library.PlayerlistData[Tostring(Player)] = {}
				local Path = Library.PlayerlistData[Tostring(Player)]
				
				local TextButton = Library:Create('TextButton', {
					Parent = ScrollingFrame,
					-- Name = '',
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = '',
					BackgroundTransparency = 1,
					Size = Dim2(1, 0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});

				local PlayerName = Library:Create('TextLabel', {
					Parent = TextButton,
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = Tostring(Player),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextSize = 10;
					LayoutOrder = -100, 
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
				Library:ApplyTheme(PlayerName, 'Text', 'TextColor3')
				Library:ApplyTheme(PlayerName, 'Accent', 'TextColor3')
				
				local PlayerType = Library:Create('TextLabel', {
					Parent = TextButton,
					-- Name = '',
					FontFace = Library.Font,
					TextColor3 = Themes[Library.UTheme].Text,
					BorderColor3 = FromRgb(0, 0, 0),
					Text = 'Player',
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});
								
				local Frame = Library:Create('Frame', {
					Parent = PlayerType,
					-- Name = '',
					Position = Dim2(0, -10, 0, 0),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 1, 0, 12),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(MainHolder, 'Outline', 'BackgroundColor3')
				
				local PriorityText = Library:Create('TextLabel', {
					Parent = TextButton,
					-- Name = '',
					FontFace = Library.Font,
					TextColor3 = Tostring(Player) ~= Client.Name and Themes[Library.UTheme].Text or FromRgb(0, 0, 255),
					BorderColor3 = FromRgb(0, 0, 0),
					Text = Tostring(Player) ~= Client.Name and 'Neutral' or 'LocalPlayer',
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextSize = 10;
					BackgroundColor3 = FromRgb(255, 255, 255)
				});

				local Frame = Library:Create('Frame', {
					Parent = PriorityText,
					-- Name = '',
					Position = Dim2(0, -10, 0, 0),
					BorderColor3 = FromRgb(0, 0, 0),
					Size = Dim2(0, 1, 0, 12),
					BorderSizePixel = 0,
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(MainHolder, 'Outline', 'BackgroundColor3')
				
				local UIListLayout = Library:Create('UIListLayout', {
					Parent = TextButton,
					-- Name = '',
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalFlex = Enum.UIFlexAlignment.Fill
				});
				
				local UIPadding = Library:Create('UIPadding', {
					Parent = TextButton,
					-- Name = '',
					PaddingRight = NewDim(0, 2),
					PaddingLeft = NewDim(0, 2)
				});

				local Line = Library:Create('Frame', {
					Parent = ScrollingFrame;
					-- Name = '';
					BorderColor3 = FromRgb(0, 0, 0);
					Size = Dim2(1, 0, 0, 1);
					BorderSizePixel = 0;
					BackgroundColor3 = Themes[Library.UTheme].Outline
				});
				Library:ApplyTheme(MainHolder, 'Outline', 'BackgroundColor3')

				Path.Instance = TextButton 
				Path.Line = Line 
				Path.Priority = 'Player'
				Path.PriorityText = PriorityText

				if not Players:FindFirstChild(PlayerName.Text) then
					PlayerType.Text = 'Ai';
				end;
				
				TextButton.MouseButton1Click:Connect(function()
					if (PlayerName == Client.Name) then return end;
					PlayerName.TextColor3 = Themes[Library.UTheme].Accent 

					Library.SelectedPlayer = PlayerName.Text or ' h'

					Library.ConfigFlags['PlayerlistDropdown'](Path.PriorityText.Text)


					if Cfg.Labels.Name then
						Cfg.Labels.Name.Set('User: ' .. PlayerName.Text)

						if (Players:FindFirstChild(PlayerName.Text)) then
							Cfg.Labels.Display.Set('DisplayName: ' .. Players[Player].DisplayName);
							Cfg.Labels.Uid.Set('User Id: ' .. Players[Player].UserId);
						else
							Cfg.Labels.Display.Set('DisplayName: '.. PlayerName.Text);
							Cfg.Labels.Uid.Set('User Id: [N/A]');
						end;
					end;
				end);

				return Path 
			end;

			function Cfg.Search(Text)
				for _, Player in next, Players:GetPlayers() do 
					local Name = Tostring(Player);
					local Path = Library.PlayerlistData[Name];
					if not (Path) then return end;
					local Sanity = string.lower(Name):match(string.lower(Text)) and true or false
					Path.Instance.Visible = Sanity
					Path.Line.Visible = Sanity
				end;
			end;

			function Cfg.RemovePlayer(Player) 
				local Path = Library.PlayerlistData[Tostring(Player)]
				Path.Instance:Destroy() 
				Path.Line:Destroy() 
				Path = nil 
			end;

			function Library.Prioritize(Text) 
				if not (Library.SelectedPlayer or not Library.PlayerlistData) then
                    return
				end;
				local Path = Library.PlayerlistData[Library.SelectedPlayer]
				Path.PriorityText.Text = Text
				Path.PriorityText.TextColor3 = Patterns[Text]
				Path.Priority = Text
			end;

			function Library.GetPriority(Player) 
				local Path = Library.PlayerlistData[Tostring(Player)]

				if Path then
					return Path.Priority
				end;
			end;

			Players.PlayerAdded:Connect(Cfg.CreatePlayer)
			Players.PlayerRemoving:Connect(Cfg.RemovePlayer)
			
            function Cfg.AddEntry(Obj, Type)
                local Path

                if Type == 'Group' then
                    --// Very scuffed indeed
                    Path = {Name = Obj.Name, Members = Obj};
                    for _, Entry in ipairs(Library.PlayerlistData) do
                        if (Entry.Members and Entry.Name == Path.Name) then
                            for _, Member in ipairs(Path) do
                                InsertTable(Entry.Members, Member)
                            end;
                            return Entry
                        end;
                    end;
                    InsertTable(Library.PlayerlistData, Path)
                    Cfg.CreatePlayer(Obj)
                elseif Type == 'Single' then
                    Path = Cfg.CreatePlayer(Obj)
                    InsertTable(Library.PlayerlistData, Path)
                end;

                return Path
            end;

			for _, Player in Players:GetPlayers() do 
                Cfg.AddEntry(Player.Name, 'Single')
			end;

			self:Textbox({Name = 'Search', Callback = function(Value)
				Cfg.Search(Value)
			end});
            
			Cfg.Labels.Name = self:Label({Name = 'Name: ..?'});
			Cfg.Labels.Display = self:Label({Name = 'Display Name: ..?'});
			Cfg.Labels.Uid = self:Label({Name = 'User Id: ..?'});

			return Setmetatable(Cfg, Library)
		end;
        
return Library, Themes;
