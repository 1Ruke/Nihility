local Camera, InputService, CoreGui, Base, Module = workspace.CurrentCamera, game:GetService('UserInputService'), gethui(), game:GetObjects(getcustomasset('AfFov.rbxm'))[1],, {};
local GuiMain, Center = Instance.new('GuiMain', CoreGui), (Camera.ViewportSize / 2);
GuiMain.IgnoreGuiInset = true;

Module.__index = Module;

type settings = {
	Enabled: boolean,
	FovOrigin: string,
	Size: number,
	
	Filled: boolean,
	FilledColor: Color3,
	FilledGradient: boolean,
	FilledGradientSpin: boolean,
	FilledGradientRotation: number,
	FilledGradientColor: ColorSequence,
	
	FovInlineColor: Color3,
	FovInlineGradient: boolean,
	FovInlineGradientSpin: boolean,
	FovInlineGradientRotation: number,
	FovInlineGradientColor: ColorSequence,
	
	GradientRotationSpeed: number,
};


Module.new = function(...)
	local self = setmetatable({
		Objects = {},
	}, Module);

	self:CreateInstance();
	
	return self;
end;

Module.CreateInstance = function(self)
	local Objects = self.Objects;
	Objects.Main = Base.Main:Clone();

	for i, v in pairs(Objects) do
		v.Parent = GuiMain;
	end;
end;

Module.RenderFov = function(self, Settings)
	local Objects = self.Objects;
	if (not Settings.Enabled or not Settings.Size or not Settings.FovOrigin) then Objects.Main.Visible = false; return; end;
	Objects.Main.Visible = true;
	Objects.Main.Size = UDim2.fromOffset(Settings.Size, Settings.Size);

	if (Settings.FovOrigin == 'Mouse') then
		local MousePos = InputService.GetMouseLocation(InputService);
		Objects.Main.Position = UDim2.fromOffset(MousePos.X, MousePos.Y);
	elseif (Settings.FovOrigin == 'ToScreen') then
		Objects.Main.Position = UDim2.fromOffset(Center.X, Center.Y);
	end;
	
	if (Settings.Filled and Settings.FilledGradient) then
		Objects.Main.Gradient.Enabled = true;
		Objects.Main.Gradient.Transparency = (Settings.FilledTransparency);
		Objects.Main.Gradient.Color = (Settings.FilledGradientColor or ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 21, 142)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))}));
	elseif (Settings.Filled and not Settings.FilledGradient) then
		Objects.Main.Gradient.Enabled = false;
		Objects.Main.BackgroundTransparency = (Settings.FilledTransparency);
		Objects.Main.Gradient.Color = ColorSequence.new(Settings.FilledColor);
	elseif (not Settings.Filled) then
		Objects.Main.Visiible = false;
	end;
	
	if (Settings.FovInlineGradient) then
		Objects.Main.Inline.Gradient.Enabled = true;
		Objects.Main.Inline.Gradient.Color = (Settings.FovInlineGradientColor or ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 21, 142)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))})); 
	else
		Objects.Main.Inline.Gradient.Enabled = false;
		Objects.Main.Inline.Color = (Settings.FovInlineColor);
	end;
	
	if (Settings.FilledGradientSpin) then
		Objects.Main.Gradient.Rotation += (Settings.GradientRotationSpeed or 1);
	else
		Objects.Main.Gradient.Rotation = (Settings.FilledGradientRotation or -90);
	end;
	
	if (Settings.FovInlineGradientSpin) then
		Objects.Main.Inline.Gradient.Rotation += (Settings.GradientRotationSpeed or 1);
	else
		Objects.Main.Inline.Gradient.Rotation = (Settings.FovInlineGradientRotation or 90);
	end;
end;
	
Module.Render = function(self, _Settings: settings)
	if (not _Settings.Enabled) then self.Objects.Main.Visible = false; return end;
	self:RenderFov(_Settings);
end;

return Module;
