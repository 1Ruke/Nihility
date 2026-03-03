--// Making this was cancerous

--// Main
	local Camera, CoreGui, Base, Dirs, Module = cloneref(workspace.CurrentCamera), gethui(), game:GetObjects(getcustomasset('Esp.rbxm'))[1], {Vector3.new(-1 -1 -1), Vector3.new(1 -1 -1), Vector3.new(-1, 1 -1), Vector3.new(1, 1 -1), Vector3.new(-1 -1, 1), Vector3.new(1 -1, 1), Vector3.new(-1, 1, 1), Vector3.new(1, 1, 1)}, {Cache = {}};
	local GuiMain = Instance.new("GuiMain", CoreGui);
	GuiMain.IgnoreGuiInset = (true);

	Module.__index = Module;

	type settings = {
		Enabled: boolean,

		Name: boolean,
		NameColor: Color3,

		Box: boolean,
		InlineBoxColor: Color3,
		InlineGradient: boolean,
		InlineGradientSpin: boolean,
		InlineGradientColor: ColorSequence,

		FilledBox: boolean,
		FilledColor: Color3,
		FilledGradient: boolean,
		FilledGradientSpin: boolean,
		FilledGradientColor: ColorSequence,
		FilledTransparency: NumberSequence,

		Weapon: boolean,
		WeaponColor: Color3,

		Distance: boolean,
		DistanceColor: Color3,

		HealthBar: boolean,
		HealthNumber: boolean,
		-- HealthBarSide: string,

		Chams: boolean,
		VisChamType: string,
        OccChamType: string,
		VisChamColor: Color3,
        OccChamColor: Color3,
		VisChamTransparency: number,
        OccChamTransparency: number,

		-- Flags: boolean, // Todo (again) lmao
		-- _Flags: {string},

		MaxDistance: number,

		GradientRotationSpeed: number,
	};

	Module.new = function(Char: Model)
		local self = setmetatable({
			HealthPercent = (1),
			Character = (Char),
			Connections = {},
			Adornments = ({V = {}, O = {}}),
			Children = ({}),
			Objects = ({}),
			Distance = (0),
			Health = (100),
		}, Module);

		self:CreateInstances();
		self.Objects.Name.Text = (Char.Name);

		local Children = Char:GetChildren();
		for i = 1, #Children do
			local v = (Children[i]);
			self.Children[v.Name] = (v);

			if (not v:IsA("BasePart") or v.Name == 'HumanoidRootPart' or v.Name == 'FaceHitBox' or v.Name == 'HeadTopHitBox') then continue end;
			if v.Name == 'Head' then
				local VHCham = Instance.new('SphereHandleAdornment');
				VHCham.Adornee = (v);
				VHCham.Name = (v.Name);
				VHCham.Transparency = 1;
				VHCham.Radius = (0.6967);
				VHCham.Parent = (CoreGui);
				table.insert(self.Adornments.V, VHCham);

				local IHCham = Instance.new('SphereHandleAdornment');
				IHCham.Adornee = (v);
				IHCham.Name = (v.Name);
				IHCham.Transparency = 1;
				IHCham.Radius = (0.6966);
				IHCham.Parent = (CoreGui);
				table.insert(self.Adornments.O, IHCham);
				continue;
			end;

			local VCham = Instance.new('BoxHandleAdornment');
			VCham.Adornee = (v);
			VCham.Name = (v.Name);
			VCham.Transparency = 1;
			VCham.Parent = (CoreGui);
			VCham.Size = (v.Size + Vector3.new((32 ^ - 10), (32 ^ -10), (32 ^ -10)));
			table.insert(self.Adornments.V, VCham);

			local OCham = Instance.new('BoxHandleAdornment');
			OCham.Adornee = (v);
			OCham.Name = (v.Name);
			OCham.Transparency = 1;
			OCham.Parent = (CoreGui);
			OCham.Size = (v.Size + Vector3.new((32 ^ -10000), (32 ^ -10000), (32 ^ -10000)));
			table.insert(self.Adornments.O, OCham);
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

		self.Cache[Char] = (self);

		return self;
	end;
--]]

--// Util
	local Wtp = function(Pos)
		local Point, On = Camera:WorldToViewportPoint(Pos);
		return (Vector2.new(Point.X, Point.Y)), (On), (Point.Z);
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

        for i, v in pairs(self.Adornments.V) do
            v.Visible = (false);
        end;

        for i, v in pairs(self.Adornments.O) do
            v.Visible = (false);
        end;

        return;
	end;

	Module.Destroy = function(self)
		for i, v in pairs(self.Connections) do
			v:Disconnect();
		end;

		for i, v in pairs(self.Objects) do
			v:Destroy();
		end;

        for i, v in pairs(self.Adornments.V) do
            v:Destroy();
        end;

        for i, v in pairs(self.Adornments.O) do
            v:Destroy();
        end;

		self.Cache[self.Character] = nil;

        return;
	end;
--]]

--// Objects
	Module.GetBoundingBox = function(self)
		local Top: number, Bottom: number, Left: number, Right: number, Valid = (math.huge), (-math.huge), (math.huge), (-math.huge), (false);
		for _, Part in pairs(self.Children) do
			if (typeof(Part) ~= 'Instance' or not Part:IsA('BasePart')) then continue end;
				local Size = (Part.Size * 0.5);
				for i = 1, #Dirs do
					Dir = (Dirs[i]);
					local Point, OnScreen = Wtp(Part.CFrame * Vector3.new((Dir.X * Size.X), ( Dir.Y * Size.Y), (Dir.Z * Size.Z)));
					if (not OnScreen) then
                        self:Hide();
                        continue;
                    else
						Top = math.min(Top, Point.Y);
						Bottom = math.max(Bottom, Point.Y);
						Left = math.min(Left, Point.X);
						Right = math.max(Right, Point.X);
                        Valid = (true);
					end;
				end;
			end;

		if ((not Valid) or (Left >= Right) or (Top >= Bottom)) then return nil; end;

		return (Top), (Bottom), (Left), (Right);
	end;

	Module.RenderBox = function(self: table, Top: number, Bottom: number, Left: number, Right: number, Settings: table)
		local Objects = (self.Objects);
		if (not Settings.Box) then Objects.Box.Visible = (false); return; end;

		Objects.Box.Position = UDim2.fromOffset(Left - 2, Top - 2);
		Objects.Box.Size = UDim2.fromOffset((Right - Left) + 2 * 2, (Bottom - Top) + 2 * 2);

		if (Settings.InlineGradient) then
			Objects.Box.Inline.Gradient.Enabled = (true);
			Objects.Box.Inline.Gradient.Color = (Settings.InlineGradientColor);
		else
			Objects.Box.Inline.Gradient.Enabled = (false);
			Objects.Box.Inline.Color = (Settings.InlineBoxColor);
		end;

		if (Settings.FilledBox and Settings.FilledGradient) then
			Objects.Box.Visible = (true)
			Objects.Box.Transparency = 0;
			Objects.Box.Gradient.Enabled = (true);
			Objects.Box.Gradient.Color = (Settings.FilledColor);
			Objects.Box.Gradient.Transparency = (Settings.FilledTransparency);
		elseif (Settings.FilledBox and not Settings.FilledGradient) then
			Objects.Box.Transparency = 0;
			Objects.Box.Gradient.Enabled = (false);
			Objects.Box.Transparency = (Settings.FilledTransparency);
			Objects.Box.Gradient.Color = (Settings.FilledColor);
		end;

		if (Settings.InlineGradient and Settings.InlineGradientSpin) then
			Objects.Box.Inline.Gradient.Rotation += (Settings.GradientRotationSpeed or 1);
		else
			Objects.Box.Inline.Gradient.Rotation = (90);
		end;

		if (Settings.FilledBox and Settings.FilledGradient and Settings.FilledGradientSpin) then
			Objects.Box.Gradient.Rotation += (Settings.GradientRotationSpeed or 1);
		else
			Objects.Box.Gradient.Rotation = (-90);
		end;
	end;

	Module.RenderName = function(self: table, Top: number, _, Left: number, Right: number, Settings: table)
		local Objects = (self.Objects);
		if (not Settings.Name) then Objects.Name.Visible = (false); return; end;

		Objects.Name.Visible = (true);
		Objects.Name.TextColor3 = Settings.NameColor;
		Objects.Name.Position = UDim2.fromOffset((Left + Right) / 2, Top - (Objects.Name.TextSize - 1));
	end;

	Module.RenderWeapon = function(self: table, _, Bottom: number, Left: number, Right: number, Settings: table)
		local Objects = (self.Objects);
		if (not Settings.Weapon) then Objects.Weapon.Visible = (false); return; end;

		Objects.Weapon.Text = 'M4A1';
		Objects.Weapon.Visible = (true);
		Objects.Weapon.TextColor3 = Settings.WeaponColor;
		Objects.Weapon.Position = UDim2.fromOffset((Left + Right) / 2, (Bottom + Objects.Weapon.TextSize) + 3);
	end;

	Module.RenderHealth = function(self: table, Top: number, Bottom: number, Left: number, Right: number, Settings: table)
		local Objects = (self.Objects);
		if (not Settings.HealthBar) then Objects.Health.Visible = (false); return; end;
		Objects.Health.Visible = (true);
		Objects.Health.Bar.Visible = (true);
		Objects.Health.Size = UDim2.new(0, Objects.Health.Size.X.Offset, 0, (Bottom - Top) + 8);
		Objects.Health.Bar.Size = UDim2.new(0, 1, self.HealthPercent, 0);
        Objects.Health.Position = UDim2.fromOffset((Left - Objects.Health.Size.X.Offset) - 7, (Top + (Bottom - Top) * 0.5 - Objects.Health.Size.Y.Offset * 0.5));
        --[[
            if Settings.HealthBarSide == 'Left,' then
                Objects.Health.Position = UDim2.fromOffset((Left - Objects.Health.Size.X.Offset) - 7, (Top + (Bottom - Top) * 0.5 - Objects.Health.Size.Y.Offset * 0.5)); --// Left,
            elseif Settings.HealthBarSide == 'Right,' then
                Objects.Health.Position = UDim2.fromOffset((Right + Objects.Health.Size.X.Offset) + 7, (Top + (Bottom - Top) * 0.5 - Objects.Health.Size.Y.Offset * 0.5)); --// Right,
            end;
        ]]

		if (not Settings.HealthNumber) then Objects.Health.Bar.HealthNum.Visible = (false); return end;
		Objects.Health.Bar.HealthNum.Visible = (true);
		Objects.Health.Bar.HealthNum.Text = `[{math.floor(self.Health)}]`;
        Objects.Health.Bar.HealthNum.Position = UDim2.fromOffset(-4, (Objects.Health.Bar.Size.Y.Scale * Objects.Health.Size.Y.Offset) - 4);
        
        --[[
            if Settings.HealthBarSide == 'Left,' then
                Objects.Health.Bar.HealthNum.Position = UDim2.fromOffset(-4, (Objects.Health.Bar.Size.Y.Scale * Objects.Health.Size.Y.Offset) - 4); --// Left,
            elseif Settings.HealthBarSide == 'Right,' then
                Objects.Health.Bar.HealthNum.Position = UDim2.fromOffset(23, (Objects.Health.Bar.Size.Y.Scale * Objects.Health.Size.Y.Offset) - 4); --// Right,
            end;
        ]]
	end;

	Module.RenderDistance = function(self: table, _, Bottom: number, Left: number, Right: number, Settings: table)
		local Objects = (self.Objects);
		if (not Settings.Distance) then Objects.Distance.Visible = (false); return; end;

		Objects.Distance.Text = (`{self.Distance} [M]`);
		Objects.Distance.Visible = (true);
		Objects.Distance.Position = UDim2.fromOffset((Left + Right) / 2, Bottom + Objects.Distance.TextSize + (Settings.Weapon and 14 or 4));
		Objects.Distance.TextColor3 = Settings.DistanceColor;
	end;

	Module.RenderChams = function(self: table, Settings: table)
		if (not Settings.Chams) then return; end;
		local VAdorn, OAdorn = (self.Adornments.V), (self.Adornments.O);

		for i = 1, #VAdorn do
			local v = (VAdorn[i]);
            v.ZIndex = 3000;
			v.Color3 = (Settings.OccChamColor);
			v.Transparency = (Settings.VisChamTransparency);

			if (Settings.VisChamType == 'Glow') then
				v.Transparency = -1;
				v.Shading = (Enum.AdornShading.AlwaysOnTop);
				v.Color3 = (Color3.new((Settings.VisChamColor.R * 100), (Settings.VisChamColor.G * 100), (Settings.VisChamColor.B * 100)));
			elseif (Settings.VisChamType == 'AlwaysOnTop') then
				v.Shading = (Enum.AdornShading.AlwaysOnTop);
			elseif Settings.VisChamType == 'Flat' then
				v.Shading = (Enum.AdornShading.XRay);
			elseif Settings.VisChamType == 'FlatShaded' then
				v.Shading = (Enum.AdornShading.XRayShaded)
			end;
		end;

		for i = 1, #OAdorn do
			local v = (OAdorn[i]);
            v.ZIndex = 2000;
			v.Color3 = (Settings.VisChamColor); --// P100 man setting Occlued to Vis lmao?
			v.Transparency = (Settings.OccChamTransparency);
			if (Settings.OccChamType == 'Glow' and not Settings.ChamOcclusion) then
				v.Transparency = -1;
				v.Shading = (Enum.AdornShading.XRay);
				v.Color3 = (Color3.new((Settings.OccChamColor.R * 100), (Settings.OccChamColor.G * 100), (Settings.OccChamColor.B * 100)));
			elseif (Settings.OccChamType == 'AlwaysOnTop') then
				v.Shading = (Enum.AdornShading.AlwaysOnTop);
			elseif Settings.OccChamType == 'Flat' then
				v.Shading = (Enum.AdornShading.XRay);
			end;
		end;
	end;
--]]

--// Render
	Module.Render = function(self: table, _Settings: settings)
        if (not self.Children.HumanoidRootPart) then self:Destroy(); return; end;
		local Top: number, Bottom: number, Left: number, Right: number = self:GetBoundingBox();
		self.Distance = math.floor((self.Children.HumanoidRootPart.Position - Camera.CFrame.Position).Magnitude / 3);
		if ((not _Settings.Enabled) or (not Top) or (self.Distance > _Settings.MaxDistance)) then self:Hide(); return; end;

		self:RenderBox(Top, Bottom, Left, Right, _Settings);
		self:RenderName(Top, Bottom, Left, Right, _Settings);
		self:RenderWeapon(Top, Bottom, Left, Right, _Settings);
		self:RenderHealth(Top, Bottom, Left, Right, _Settings);
		self:RenderDistance(Top, Bottom, Left, Right, _Settings);
		self:RenderChams(_Settings);
	end;
--]]

return Module;
