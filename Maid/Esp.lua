--// Main
	local Camera, CoreGui, Base, Dirs, Module = game.Workspace.CurrentCamera, game.Players.LocalPlayer.PlayerGui, script.P100Hook:Clone(), {Vector3.new(-1, -1, -1), Vector3.new(1, -1, -1), Vector3.new(-1, 1, -1), Vector3.new(1, 1, -1), Vector3.new(-1, -1, 1), Vector3.new(1, -1, 1), Vector3.new(-1, 1, 1), Vector3.new(1, 1, 1)}, {Cache = {}};
	local GuiMain = Instance.new("GuiMain", CoreGui);
	GuiMain.IgnoreGuiInset = (true);

	Module.__index = Module;

	type settings = {
		Enabled: boolean,

		Name: boolean,
		NameColor: Color3,
	
		Box: boolean,
		BoxColor: Color3,
		BoxFilled: boolean,
		BoxGradient: boolean,
		BoxGradientColor: ColorSequence,
		BoxTransparency: NumberSequence,
	
		Weapon: boolean,
		WeaponColor: Color3,

		Distance: boolean,
		DistanceColor: Color3,

		HealthBar: boolean,
		HealthNumber: boolean,
		HealthBarSide: string,
	
		Cham: boolean,
		ChamType: string,
		ChamColor: Color3,
		ChamOcclusion: boolean,
	
		Flags: boolean,
		_Flags: {string},
	
		MaxDistance: number,
	};

	Module.new = function(Char: Model)
		local self = setmetatable({
			HealthPercent = 1,
			Character = Char,
			Connections = {},
			Adornments = {},
			Children = {},
			Objects = {},
			Distance = 0,
			Health = 100,
		}, Module);

		self:CreateInstances();
		self.Objects.Name.Text = Char.Name;

		local Children = Char:GetChildren();
		for i = 1, #Children do
			local v = Children[i];
			self.Children[v.Name] = v;

			if (not v:IsA("BasePart") or v.Name == 'HumanoidRootPart') then continue end;

			if v.Name == 'Head' then
				local HCham = Instance.new('SphereHandleAdornment');
				HCham.Adornee = (v);
				HCham.Name = (v.Name);
				HCham.Transparency = 1;
				HCham.Radius = (0.6967);
				HCham.Parent = (CoreGui);
				table.insert(self.Adornments, HCham);
				continue
			end;

			local Cham = Instance.new('BoxHandleAdornment');
			Cham.Adornee = (v);
			Cham.Name = (v.Name);
			Cham.Transparency = 1;
			Cham.Parent = (CoreGui);
			Cham.Size = (v.Size + Vector3.new(0.1, 0.1, 0.1));
			table.insert(self.Adornments, Cham);
		end;

		table.insert(self.Connections, self.Children.Humanoid.AncestryChanged:Connect(function() 
			self:Destroy();	
		end));

		--// Initial
		self.Health = (self.Children.Humanoid.Health);
		self.HealthPercent = (1 - (self.Health / self.Children.Humanoid.MaxHealth));

		table.insert(self.Connections, self.Children.Humanoid.HealthChanged:Connect(function()
			self.Health = (self.Children.Humanoid.Health);
			self.HealthPercent = (1 - (self.Health / self.Children.Humanoid.MaxHealth));
		end))

		self.Cache[Char] = self;

		return self;
	end;
--]]

--// Util
	local Wtp = function(Pos)
		local point, on = Camera:WorldToViewportPoint(Pos);
		return Vector2.new(point.X, point.Y), on, point.Z;
	end;

	Module.CreateInstances = function(self)
		local Objects = (self.Objects);
		Objects.Box = Base.Box:Clone();
		Objects.Name = Base._Name:Clone();
		Objects.Weapon = Base.Weapon:Clone();
		Objects.Health = Base.Health:Clone();
		Objects.Distance = Base.Distance:Clone();
		for i, v in pairs(Objects) do
			v.Parent = GuiMain;
		end;
	end;

	Module.Hide = function(self) 
		for i, v in pairs(self.Objects) do
			v.Visible = (false);
		end;
	end;

	Module.Destroy = function(self)
		for i, v in pairs(self.Connections) do
			v:Disconnect();
		end;

		for i, v in pairs(self.Objects) do
			v:Destroy();
		end;

		self.Cache[self.Character] = nil;
	end;
--]]

--// Objects
	Module.GetBoundingBox = function(self)
		local Top, Bottom, Left, Right, Valid = math.huge, -math.huge, math.huge, -math.huge, false;
		for _, Part in pairs(self.Children) do
			if (typeof(Part) == 'Instance' and Part:IsA('BasePart')) then
				local Size = Part.Size * 0.5;
				for i = 1, #Dirs do
					Dir = Dirs[i];
					local Point, OnScreen = Wtp(Part.CFrame * Vector3.new(Dir.X * Size.X, Dir.Y * Size.Y, Dir.Z * Size.Z));
					if (OnScreen) then
						Valid = (true);
						Top = math.min(Top, Point.Y);
						Bottom = math.max(Bottom, Point.Y);
						Left = math.min(Left, Point.X);
						Right = math.max(Right, Point.X);
					end;
				end;
			end;
		end;

		if (not Valid or Left >= Right or Top >= Bottom) then return nil end;

		return Top, Bottom, Left, Right;
	end;

	Module.RenderBox = function(self, Top, Bottom, Left, Right, Settings)
		local Objects = (self.Objects);
		if (not Settings.Box) then Objects.Box.Visible = (false); return; end;
		Objects.Box.Inline.Color = Settings.BoxColor;
		Objects.Box.Position = UDim2.fromOffset(Left - 2, Top - 2);
		Objects.Box.Size = UDim2.fromOffset((Right - Left) + 2 * 2, (Bottom - Top) + 2 * 2);
		if (not Settings.BoxFilled) then Objects.Box.Transparency = 1; return end;
		if (Settings.BoxFilled and Settings.BoxGradient) then
			Objects.Box.Visible = (true)
			Objects.Box.Transparency = 0;
			Objects.Box.Gradient.Enabled = (true);
			Objects.Box.Gradient.Transparency = (Settings.BoxTransparency);
			Objects.Box.Gradient.Color = (Settings.BoxGradientColor);
		elseif (Settings.BoxFilled and not Settings.BoxGradient) then
			Objects.Box.Transparency = 0;
			Objects.Box.Gradient.Enabled = (false);
			Objects.Box.Transparency = (Settings.BoxTransparency);
			Objects.Box.Gradient.Color = (Settings.BoxGradientColor);
		end;
	end;

	Module.RenderName = function(self, Top, _, Left, Right, Settings)
		local Objects = (self.Objects);
		if (not Settings.Name) then Objects.Name.Visible = (false); return; end;

		Objects.Name.Visible = (true);
		Objects.Name.TextColor3 = Settings.NameColor;
		Objects.Name.Position = UDim2.fromOffset((Left + Right) / 2, Top - (Objects.Name.TextSize - 1));
	end;

	Module.RenderWeapon = function(self, _, Bottom, Left, Right, Settings)
		local Objects = (self.Objects);
		if (not Settings.Weapon) then Objects.Weapon.Visible = (false); return; end;

		Objects.Weapon.Text = 'M4A1';
		Objects.Weapon.Visible = (true);
		Objects.Weapon.TextColor3 = Settings.WeaponColor;
		Objects.Weapon.Position = UDim2.fromOffset((Left + Right) / 2, (Bottom + Objects.Weapon.TextSize) + 3);
	end;

	Module.RenderHealth = function(self, Top, Bottom, Left, Right, Settings)
		local Objects = (self.Objects);
		if (not Settings.HealthBar) then Objects.Health.Visible = (false); return; end;
		Objects.Health.Visible = (true);
		Objects.Health.Bar.Visible = (true);
		Objects.Health.Size = UDim2.new(0, Objects.Health.Size.X.Offset, 0, (Bottom - Top) + 8);
		Objects.Health.Bar.Size = UDim2.new(0, 1, self.HealthPercent, 0);

		if Settings.HealthBarSide == 'Left' then
			Objects.Health.Position = UDim2.fromOffset((Left - Objects.Health.Size.X.Offset) - 7, (Top + (Bottom - Top) * 0.5 - Objects.Health.Size.Y.Offset * 0.5)); --// Left
		elseif Settings.HealthBarSide == 'Right' then
			Objects.Health.Position = UDim2.fromOffset((Right + Objects.Health.Size.X.Offset) + 7, (Top + (Bottom - Top) * 0.5 - Objects.Health.Size.Y.Offset * 0.5)); --// Right
		end;

		if (not Settings.HealthNumber) then Objects.Health.Bar.HealthNum.Visible = (false); return end;
		Objects.Health.Bar.HealthNum.Visible = (true);
		Objects.Health.Bar.HealthNum.Text = `[{math.floor(self.Health)}]`;

		if Settings.HealthBarSide == 'Left' then
			Objects.Health.Bar.HealthNum.Position = UDim2.fromOffset(-4, (Objects.Health.Bar.Size.Y.Scale * Objects.Health.Size.Y.Offset) - 4); --// Left
		elseif Settings.HealthBarSide == 'Right' then
			Objects.Health.Bar.HealthNum.Position = UDim2.fromOffset(23, (Objects.Health.Bar.Size.Y.Scale * Objects.Health.Size.Y.Offset) - 4); --// Right
		end;
	end;

	Module.RenderDistance = function(self, _, Bottom, Left, Right, Settings)
		local Objects = (self.Objects);
		if (not Settings.Distance) then Objects.Distance.Visible = (false); return; end;

		Objects.Distance.Text = math.floor(self.Distance / 3) .. " [M]";
		Objects.Distance.Visible = (true);
		Objects.Distance.Position = UDim2.fromOffset((Left + Right) / 2, Bottom + Objects.Distance.TextSize + (Settings.Weapon and 14 or 4));
		Objects.Distance.TextColor3 = Settings.DistanceColor;
	end;

	Module.RenderChams = function(self, Settings)
		if (not Settings.Chams) then return; end;
		local Adorn = (self.Adornments);

		for i = 1, #Adorn do
			local v = Adorn[i];
			v.Color3 = (Settings.ChamColor);
			v.Transparency = (Settings.ChamsTransparency);
			v.ZIndex = (Settings.ChamOcclusion and 0 or -1);

			if (Settings.ChamShading == 'Glow' and not Settings.ChamOcclusion) then
				v.Transparency = -1;
				v.Shading = (Enum.AdornShading.XRay);
				v.Color3 = (Color3.new((Settings.ChamColor.R * 500), (Settings.ChamColor.G * 500), (Settings.ChamColor.B * 500)));
			elseif (Settings.ChamShading == 'AlwaysOnTop') then
				v.Shading = (Enum.AdornShading.AlwaysOnTop);
			elseif Settings.ChamShading == 'Flat' then
				v.Shading = (Enum.AdornShading.XRay);
			end;
		end;
	end;
--]]

--// Render
	Module.Render = function(self, _Settings: settings)
		local Top, Bottom, Left, Right = self:GetBoundingBox();
		self.Distance = (self.Children.HumanoidRootPart.Position - Camera.CFrame.Position).Magnitude;
		if (self.Distance > _Settings.MaxDistance) then return end;
		if (not _Settings.Enabled or not Top) then self:Hide() return end;
		self:RenderBox(Top, Bottom, Left, Right, _Settings);
		self:RenderName(Top, Bottom, Left, Right, _Settings);
		self:RenderWeapon(Top, Bottom, Left, Right, _Settings);
		self:RenderHealth(Top, Bottom, Left, Right, _Settings);
		self:RenderDistance(Top, Bottom, Left, Right, _Settings);
		self:RenderChams(_Settings);
	end;
--]]

return Module;
