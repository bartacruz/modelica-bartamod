within Bartamod;

package Controllers "Custom motor controllers"
  extends Modelica.Icons.VariantsPackage;

  model SepExController
    parameter SI.Voltage voltage = 0 "System Voltage";
    parameter SI.Current current = 0 "System Current";
    parameter SI.Voltage weakVoltage = 0 "Field-Weakening Voltage";
    Modelica.Blocks.Interfaces.RealInput accel "Accelerator (0..1)" annotation(
      Placement(transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
    Modelica.Electrical.Analog.Interfaces.PositivePin armature_p "Armature Positive pin" annotation(
      Placement(transformation(origin = {40, -120}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin armature_n "Armature Negative pin" annotation(
      Placement(transformation(origin = {-40, -120}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin field_p "Field Positive pin" annotation(
      Placement(transformation(origin = {-120, -40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin field_n "Field Negative pin" annotation(
      Placement(transformation(origin = {-120, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin batt_p "Battery Positive pin" annotation(
      Placement(transformation(origin = {120, -40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin batt_n "Battery Negative pin" annotation(
      Placement(transformation(origin = {120, 40}, extent = {{-10, -10}, {10, 10}})));Modelica.Electrical.Analog.Sources.SignalVoltage voltageArmature annotation(
      Placement(transformation(origin = {-26, -86}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentArmature annotation(
      Placement(transformation(origin = {0, -86}, extent = {{-10, 10}, {10, -10}})));
    Modelica.Electrical.Analog.Sources.SignalVoltage voltageField annotation(
      Placement(transformation(origin = {-108, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain(k = current) annotation(
      Placement(transformation(origin = {82, 88}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Blocks.Continuous.LimPID PIArmature(Ni = 0.9, Ti = 0.2, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 2, yMax = 72, yMin = 0) annotation(
      Placement(transformation(origin = {74, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Blocks.Logical.Switch switch1 annotation(
      Placement(transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.RealToBoolean AccelOnOff(threshold = 0.01) annotation(
      Placement(transformation(origin = {-40, 98}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.Constant KVoltage(k = voltage) annotation(
      Placement(transformation(origin = {-16, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.Constant KRegenField(k = voltage*0.5) annotation(
      Placement(transformation(origin = {-62, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Logical.Switch switchArmature annotation(
      Placement(transformation(origin = {74, 44}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.Constant KRegen(k = -100) annotation(
      Placement(transformation(origin = {40, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Continuous.LimPID PIField(Ni = 0.9, Ti = 0.02, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 5, yMax = 72, yMin = 0) annotation(
      Placement(transformation(origin = {-84, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Nonlinear.SlewRateLimiter slewField(Rising = 10000, Falling = -40) annotation(
      Placement(transformation(origin = {-62, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(
      Placement(transformation(origin = {-70, 0}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
    Modelica.Blocks.Nonlinear.SlewRateLimiter slewArmature(Falling = -5000, Rising = 500) annotation(
      Placement(transformation(origin = {74, 6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    SepExFieldWeakening fieldWeakening(minV = 70, refThreshold = 2, timeThreshold = 0.5, kFW = 0.2, maxCorrection = 30) annotation(
      Placement(transformation(origin = {0, -26}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(transformation(origin = {-120, 22}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(transformation(origin = {-60, -114}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground ground11 annotation(
      Placement(transformation(origin = {114, 20}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(gain.y, switchArmature.u1) annotation(
      Line(points = {{82, 77}, {82, 56}}, color = {0, 0, 127}));
    connect(KRegen.y, switchArmature.u3) annotation(
      Line(points = {{40, 55}, {40, 64}, {66, 64}, {66, 56}}, color = {0, 0, 127}));
    connect(accel, AccelOnOff.u) annotation(
      Line(points = {{0, 120}, {-40, 120}, {-40, 110}}, color = {0, 0, 127}));
    connect(KRegenField.y, switch1.u3) annotation(
      Line(points = {{-62, 49}, {-62, 40}, {-48, 40}, {-48, 32}}, color = {0, 0, 127}));
    connect(AccelOnOff.y, switch1.u2) annotation(
      Line(points = {{-40, 87}, {-40, 32}}, color = {255, 0, 255}));
    connect(AccelOnOff.y, switchArmature.u2) annotation(
      Line(points = {{-40, 87}, {-40, 74}, {74, 74}, {74, 56}}, color = {255, 0, 255}));
    connect(KVoltage.y, switch1.u1) annotation(
      Line(points = {{-16, 49}, {-16, 44}, {-32, 44}, {-32, 32}}, color = {0, 0, 127}));
    connect(voltageField.p, field_p) annotation(
      Line(points = {{-108, -10}, {-108, -40}, {-120, -40}}, color = {0, 0, 255}));
    connect(voltageField.n, field_n) annotation(
      Line(points = {{-108, 10}, {-108, 40}, {-120, 40}}, color = {0, 0, 255}));
    connect(voltageSensor.n, voltageField.n) annotation(
      Line(points = {{-70, 10}, {-108, 10}}, color = {0, 0, 255}));
    connect(voltageSensor.p, voltageField.p) annotation(
      Line(points = {{-70, -10}, {-108, -10}}, color = {0, 0, 255}));
    connect(switchArmature.y, slewArmature.u) annotation(
      Line(points = {{74, 33}, {74, 18}}, color = {0, 0, 127}));
    connect(PIArmature.y, voltageArmature.v) annotation(
      Line(points = {{74, -51}, {74, -64}, {-26, -64}, {-26, -74}}, color = {0, 0, 127}));
    connect(slewArmature.y, PIArmature.u_s) annotation(
      Line(points = {{74, -5}, {74, -29}}, color = {0, 0, 127}));
    connect(slewField.y, PIField.u_s) annotation(
      Line(points = {{-73, -58}, {-84, -58}, {-84, -42}}, color = {0, 0, 127}));
    connect(voltageSensor.v, PIField.u_m) annotation(
      Line(points = {{-59, 0}, {-56, 0}, {-56, -30}, {-72, -30}}, color = {0, 0, 127}));
    connect(PIField.y, voltageField.v) annotation(
      Line(points = {{-84, -19}, {-84, 0}, {-96, 0}}, color = {0, 0, 127}));
    connect(currentArmature.n, armature_p) annotation(
      Line(points = {{10, -86}, {40, -86}, {40, -120}}, color = {0, 0, 255}));
    connect(PIArmature.y, fieldWeakening.u_arm) annotation(
      Line(points = {{74, -51}, {74, -64}, {-6, -64}, {-6, -38}}, color = {0, 0, 127}));
    connect(currentArmature.i, fieldWeakening.measured_i) annotation(
      Line(points = {{0, -74}, {0, -38}}, color = {0, 0, 127}));
    connect(slewArmature.y, fieldWeakening.desired_i) annotation(
      Line(points = {{74, -5}, {74, -20}, {44, -20}, {44, -46}, {6, -46}, {6, -38}}, color = {0, 0, 127}));
    connect(switch1.y, fieldWeakening.u) annotation(
      Line(points = {{-40, 10}, {-40, -2}, {22, -2}, {22, -26}, {12, -26}}, color = {0, 0, 127}));
    connect(fieldWeakening.y, slewField.u) annotation(
      Line(points = {{-11, -26}, {-40, -26}, {-40, -58}, {-50, -58}}, color = {0, 0, 127}));
    connect(ground.p, field_n) annotation(
      Line(points = {{-120, 32}, {-120, 40}}, color = {0, 0, 255}));
    connect(currentArmature.i, PIArmature.u_m) annotation(
      Line(points = {{0, -74}, {0, -70}, {94, -70}, {94, -40}, {86, -40}}, color = {0, 0, 127}));
    connect(batt_n, ground11.p) annotation(
      Line(points = {{120, 40}, {114, 40}, {114, 30}}, color = {0, 0, 255}));
    connect(armature_n, ground1.p) annotation(
      Line(points = {{-40, -120}, {-40, -96}, {-60, -96}, {-60, -104}}, color = {0, 0, 255}));
    connect(voltageArmature.n, currentArmature.p) annotation(
      Line(points = {{-16, -86}, {-10, -86}}, color = {0, 0, 255}));
    connect(voltageArmature.p, batt_p) annotation(
      Line(points = {{-36, -86}, {-36, -102}, {106, -102}, {106, -40}, {120, -40}}, color = {0, 0, 255}));
    connect(accel, gain.u) annotation(
      Line(points = {{0, 120}, {82, 120}, {82, 100}}, color = {0, 0, 127}));
    annotation(
      defaultComponentName = "sepEx",
      Diagram(coordinateSystem(extent = {{-120, 120}, {120, -120}})),
      Icon(coordinateSystem(extent = {{-130, -130}, {130, 130}}), graphics = {// Cuerpo del controlador (proporción cuadrada 120x120 relativa)
      Rectangle(extent = {{-90, 90}, {90, -90}}, lineColor = {0, 0, 0}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, lineThickness = 0.5), Ellipse(extent = {{-89, 40}, {-69, 20}}, lineColor = {0, 0, 255}), Ellipse(extent = {{-89, 20}, {-69, 0}}, lineColor = {0, 0, 255}), Ellipse(extent = {{-89, 0}, {-69, -20}}, lineColor = {0, 0, 255}), Ellipse(extent = {{-89, -20}, {-69, -40}}, lineColor = {0, 0, 255}), Rectangle(extent = {{-89, 40}, {-79, -40}}, lineColor = {230, 230, 230}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, lineThickness = 0.5), Line(points = {{-120, 40}, {-80, 40}}, color = {0, 0, 255}), Line(points = {{-120, -40}, {-80, -40}}, color = {0, 0, 255}), Line(points = {{-40, -120}, {-40, -90}}, color = {0, 0, 255}), Line(points = {{40, -120}, {40, -90}}, color = {0, 0, 255}), Text(extent = {{-150, 70}, {150, 55}}, textColor = {0, 0, 255}, textString = "%name")}));
  end SepExController;

  model SepExFieldWeakening
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Voltage minV = 0 "Min armature voltage";
    parameter SI.Voltage maxCorrection = 0 "Max correction voltage";
    parameter SI.Voltage refThreshold = 10 "Ref threshold";
    parameter SI.Time timeThreshold = 0.5 "Time threshold";
    parameter Real kFW = 1.0 "Weakening Gain";
    Modelica.Blocks.Interfaces.RealInput desired_i annotation(
      Placement(transformation(origin = {50, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {-60, -120}, extent = {{-20, 20}, {20, -20}}, rotation = -270)));
    Modelica.Blocks.Interfaces.RealInput measured_i annotation(
      Placement(transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {0, -120}, extent = {{-20, 20}, {20, -20}}, rotation = -270)));
    
    Modelica.Blocks.Interfaces.RealInput u_arm annotation(
      Placement(transformation(origin = {-50, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {64, -120}, extent = {{-20, 20}, {20, -20}}, rotation = -270)));
    Modelica.Blocks.Continuous.Derivative derivative(k = kFW, T = 0.2) annotation(
      Placement(transformation(origin = {-76, 18}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.Abs abs1 annotation(
      Placement(transformation(origin = {-46, 18}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.LessThreshold uIsConstant(threshold = timeThreshold) annotation(
      Placement(transformation(origin = {-16, 18}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.And and2 annotation(
      Placement(transformation(origin = {-14, 54}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold VuThreshold(threshold = minV) annotation(
      Placement(transformation(origin = {-78, 54}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.Switch swOutput annotation(
      Placement(transformation(origin = {60, -24}, extent = {{-10, 10}, {10, -10}})));
    Modelica.Blocks.Math.Add excess(k2 = -1) annotation(
      Placement(transformation(origin = {-36, -40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.Gain gain(k = maxCorrection) annotation(
      Placement(transformation(origin = {2, -70}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Feedback feedbackArrmature annotation(
      Placement(transformation(origin = {26, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.Division rateCorrection annotation(
      Placement(transformation(origin = {76, 54}, extent = {{10, 10}, {-10, -10}}, rotation = -180)));
  Modelica.Blocks.Logical.Switch swAvoidZero annotation(
      Placement(transformation(origin = {42, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(Rising = 200, Falling = -5000)  annotation(
      Placement(transformation(origin = {-36, -70}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1, uMin = 0)  annotation(
      Placement(transformation(origin = {44, -70}, extent = {{10, -10}, {-10, 10}})));
  equation
    connect(abs1.y, uIsConstant.u) annotation(
      Line(points = {{-35, 18}, {-28, 18}}, color = {0, 0, 127}));
    connect(u, swOutput.u3) annotation(
      Line(points = {{-120, 0}, {-34, 0}, {-34, -16}, {48, -16}}, color = {0, 0, 127}));
    connect(swOutput.y, y) annotation(
      Line(points = {{71, -24}, {92, -24}, {92, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(derivative.y, abs1.u) annotation(
      Line(points = {{-65, 18}, {-59, 18}}, color = {0, 0, 127}));
    connect(and2.y, swOutput.u2) annotation(
      Line(points = {{-3, 54}, {10, 54}, {10, -24}, {48, -24}}, color = {255, 0, 255}));
    connect(u_arm, VuThreshold.u) annotation(
      Line(points = {{-50, 120}, {-50, 96}, {-96, 96}, {-96, 54}, {-90, 54}}, color = {0, 0, 127}));
    connect(u_arm, derivative.u) annotation(
      Line(points = {{-50, 120}, {-50, 96}, {-96, 96}, {-96, 18}, {-88, 18}}, color = {0, 0, 127}));
    connect(uIsConstant.y, and2.u2) annotation(
      Line(points = {{-4, 18}, {0, 18}, {0, 40}, {-32, 40}, {-32, 46}, {-26, 46}}, color = {255, 0, 255}));
    connect(measured_i, feedbackArrmature.u2) annotation(
      Line(points = {{0, 120}, {0, 94}, {26, 94}, {26, 88}}, color = {0, 0, 127}));
    connect(desired_i, feedbackArrmature.u1) annotation(
      Line(points = {{50, 120}, {50, 80}, {34, 80}}, color = {0, 0, 127}));
    connect(and2.y, swAvoidZero.u2) annotation(
      Line(points = {{-2, 54}, {10, 54}, {10, 40}, {30, 40}}, color = {255, 0, 255}));
    connect(desired_i, swAvoidZero.u1) annotation(
      Line(points = {{50, 120}, {50, 66}, {22, 66}, {22, 48}, {30, 48}}, color = {0, 0, 127}));
    connect(u, excess.u1) annotation(
      Line(points = {{-120, 0}, {-70, 0}, {-70, -34}, {-48, -34}}, color = {0, 0, 127}));
    connect(excess.y, swOutput.u1) annotation(
      Line(points = {{-24, -40}, {0, -40}, {0, -32}, {48, -32}}, color = {0, 0, 127}));
    connect(slewRateLimiter.y, excess.u2) annotation(
      Line(points = {{-47, -70}, {-60, -70}, {-60, -46}, {-48, -46}}, color = {0, 0, 127}));
    connect(swAvoidZero.y, rateCorrection.u2) annotation(
      Line(points = {{54, 40}, {58, 40}, {58, 48}, {64, 48}}, color = {0, 0, 127}));
    connect(feedbackArrmature.y, rateCorrection.u1) annotation(
      Line(points = {{18, 80}, {16, 80}, {16, 60}, {64, 60}}, color = {0, 0, 127}));
    connect(VuThreshold.y, and2.u1) annotation(
      Line(points = {{-66, 54}, {-26, 54}}, color = {255, 0, 255}));
    connect(feedbackArrmature.y, swAvoidZero.u3) annotation(
      Line(points = {{18, 80}, {16, 80}, {16, 32}, {30, 32}}, color = {0, 0, 127}));
  connect(gain.y, slewRateLimiter.u) annotation(
      Line(points = {{-8, -70}, {-24, -70}}, color = {0, 0, 127}));
  connect(limiter.y, gain.u) annotation(
      Line(points = {{34, -70}, {14, -70}}, color = {0, 0, 127}));
  connect(rateCorrection.y, limiter.u) annotation(
      Line(points = {{88, 54}, {92, 54}, {92, 16}, {80, 16}, {80, -70}, {56, -70}}, color = {0, 0, 127}));
    annotation(
      Diagram);
  end SepExFieldWeakening;

  model SepExFieldWeakening2
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Voltage minV = 0 "Min input voltage";
    parameter SI.Voltage refThreshold = 10 "Ref threshold";
    parameter SI.Time timeThreshold = 0.5 "Time threshold";
    parameter Real kFW = 1.0 "Weakening Gain";
    Modelica.Blocks.Interfaces.RealInput ref annotation(
      Placement(transformation(origin = {50, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {-60, -120}, extent = {{-20, 20}, {20, -20}}, rotation = -270)));
    Modelica.Blocks.Interfaces.RealInput u_arm annotation(
      Placement(transformation(origin = {-50, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {64, -120}, extent = {{-20, 20}, {20, -20}}, rotation = -270)));
    Modelica.Blocks.Continuous.Derivative derivative(k = kFW, T = 0.2) annotation(
      Placement(transformation(origin = {-76, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
    Modelica.Blocks.Math.Abs abs1 annotation(
      Placement(transformation(origin = {-34, 30}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.LessThreshold uIsConstant(threshold = timeThreshold) annotation(
      Placement(transformation(origin = {-4, 30}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.And and1 annotation(
      Placement(transformation(origin = {34, 38}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.And and2 annotation(
      Placement(transformation(origin = {66, 46}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
    Modelica.Blocks.Logical.GreaterEqualThreshold VuThreshold(threshold = minV) annotation(
      Placement(transformation(origin = {-16, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold refError(threshold = refThreshold) annotation(
      Placement(transformation(origin = {50, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Logical.Switch switch1 annotation(
      Placement(transformation(origin = {62, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
    Modelica.Blocks.Math.Add excess(k2 = -1) annotation(
      Placement(transformation(origin = {-36, -32}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.Gain gain(k = kFW) annotation(
      Placement(transformation(origin = {-2, -32}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(abs1.y, uIsConstant.u) annotation(
      Line(points = {{-23, 30}, {-16, 30}}, color = {0, 0, 127}));
    connect(uIsConstant.y, and1.u2) annotation(
      Line(points = {{7, 30}, {22, 30}}, color = {255, 0, 255}));
    connect(VuThreshold.y, and1.u1) annotation(
      Line(points = {{-5, 70}, {8, 70}, {8, 38}, {22, 38}}, color = {255, 0, 255}));
    connect(and1.y, and2.u2) annotation(
      Line(points = {{45, 38}, {54, 38}}, color = {255, 0, 255}));
    connect(refError.y, and2.u1) annotation(
      Line(points = {{50, 69}, {50, 46}, {54, 46}}, color = {255, 0, 255}));
    connect(excess.y, gain.u) annotation(
      Line(points = {{-25, -32}, {-14, -32}}, color = {0, 0, 127}));
    connect(u, switch1.u3) annotation(
      Line(points = {{-120, 0}, {0, 0}, {0, 8}, {50, 8}}, color = {0, 0, 127}));
    connect(gain.y, switch1.u1) annotation(
      Line(points = {{9, -32}, {30, -32}, {30, -8}, {50, -8}}, color = {0, 0, 127}));
    connect(switch1.y, y) annotation(
      Line(points = {{74, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(ref, refError.u) annotation(
      Line(points = {{50, 120}, {50, 92}}, color = {0, 0, 127}));
    connect(u_arm, derivative.u) annotation(
      Line(points = {{-50, 120}, {-50, 90}, {-94, 90}, {-94, 30}, {-88, 30}}, color = {0, 0, 127}));
    connect(u_arm, excess.u1) annotation(
      Line(points = {{-50, 120}, {-50, 90}, {-94, 90}, {-94, -26}, {-48, -26}}, color = {0, 0, 127}));
    connect(u_arm, VuThreshold.u) annotation(
      Line(points = {{-50, 120}, {-50, 90}, {-36, 90}, {-36, 70}, {-28, 70}}, color = {0, 0, 127}));
    connect(derivative.y, abs1.u) annotation(
      Line(points = {{-64, 30}, {-46, 30}}, color = {0, 0, 127}));
    annotation(
      Diagram);
  end SepExFieldWeakening2;

  model SepExPWMController
    parameter SI.Voltage voltage = 0 "System Voltage";
    parameter SI.Current current = 0 "System Current";
    parameter SI.Voltage weakArmatureMinV = 0 "Field Weakening Armature Min Voltage";
    parameter SI.Current regenCurrent = 0 "Regen Current (positive)";
    Modelica.Blocks.Interfaces.RealInput accel "Accelerator (0..1)" annotation(
      Placement(transformation(origin = {0, 186}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {0, 140}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
    Modelica.Electrical.Analog.Interfaces.PositivePin armature_p "Armature Positive pin" annotation(
      Placement(transformation(origin = {62, -172}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {40, -120}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin armature_n "Armature Negative pin" annotation(
      Placement(transformation(origin = {-62, -172}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-40, -120}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin field_p "Field Positive pin" annotation(
      Placement(transformation(origin = {-168, -80}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-120, -40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin field_n "Field Negative pin" annotation(
      Placement(transformation(origin = {-168, 80}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-120, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin batt_p "Battery Positive pin" annotation(
      Placement(transformation(origin = {170, -82}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {120, -40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin batt_n "Battery Negative pin" annotation(
      Placement(transformation(origin = {170, 80}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {120, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground groundBatt annotation(
      Placement(transformation(origin = {154, 58}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground groundField annotation(
      Placement(transformation(origin = {-160, 62}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor armSensorA annotation(
      Placement(transformation(origin = {80, -144}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Electrical.PowerConverters.DCDC.HBridge dcdc(RonDiode = 0.001, RonTransistor = 0.001, constantEnable = true, useConstantEnable = true) annotation(
      Placement(transformation(origin = {116, -128}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM pwm(commonComparison = true, f = 10000, refType = Modelica.Electrical.PowerConverters.Types.SingleReferenceType.Sawtooth, useConstantDutyCycle = false) annotation(
      Placement(transformation(origin = {116, -94}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Blocks.Continuous.LimPID PID(Ni = 0.9, Ti = 0.01, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.03, yMax = 1, yMin = -0.9) annotation(
      Placement(transformation(origin = {80, -64}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor armSensorV annotation(
      Placement(transformation(origin = {48, -144}, extent = {{-10, -10}, {10, 10}}, rotation = -180)));
  Modelica.Blocks.Continuous.FirstOrder foCurrent(T = 0.001) annotation(
      Placement(transformation(origin = {80, -100}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Mean vArmature(f = 10000) annotation(
      Placement(transformation(origin = {2, -92}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain gain(k = current) annotation(
      Placement(transformation(origin = {24, 144}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.RealToBoolean accelOnOff(threshold = 0.01) annotation(
      Placement(transformation(origin = {-18, 136}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Logical.Switch switchArmature annotation(
      Placement(transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant KRegen(k = -1*regenCurrent) annotation(
      Placement(transformation(origin = {-36, -60}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter smooth(Falling = -5000, Rising = 500) annotation(
      Placement(transformation(origin = {28, -64}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Logical.Switch brakeOrNot annotation(
      Placement(transformation(origin = {-72, -92}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Logical.GreaterThreshold regenThreshold(threshold = 3) annotation(
      Placement(transformation(origin = {-36, -92}, extent = {{-10, -10}, {10, 10}}, rotation = -180)));
  Modelica.Blocks.Sources.Constant KZero(k = 0) annotation(
      Placement(transformation(origin = {-34, -128}, extent = {{10, -10}, {-10, 10}})));
  equation
    connect(field_n, groundField.p) annotation(
      Line(points = {{-168, 80}, {-160, 80}, {-160, 72}}, color = {0, 0, 255}));
    connect(pwm.fire, dcdc.fire_p) annotation(
      Line(points = {{122, -105}, {122, -116}}, color = {255, 0, 255}));
    connect(pwm.notFire, dcdc.fire_n) annotation(
      Line(points = {{110, -105}, {110, -116}}, color = {255, 0, 255}));
  connect(accelOnOff.y, switchArmature.u2) annotation(
      Line(points = {{-18, 125}, {-18, 53.5}, {0, 53.5}, {0, -16}}, color = {255, 0, 255}));
  connect(armSensorV.p, armature_p) annotation(
      Line(points = {{58, -144}, {62, -144}, {62, -172}}, color = {0, 0, 255}));
  connect(armSensorV.n, armature_n) annotation(
      Line(points = {{38, -144}, {-62, -144}, {-62, -172}}, color = {0, 0, 255}));
  connect(foCurrent.y, PID.u_m) annotation(
      Line(points = {{80, -89}, {80, -76}}, color = {0, 0, 127}));
  connect(armSensorV.p, armSensorA.n) annotation(
      Line(points = {{58, -144}, {70, -144}}, color = {0, 0, 255}));
  connect(dcdc.dc_p2, armSensorA.p) annotation(
      Line(points = {{106, -134}, {102, -134}, {102, -144}, {90, -144}}, color = {0, 0, 255}));
  connect(vArmature.u, armSensorV.v) annotation(
      Line(points = {{14, -92}, {48, -92}, {48, -133}}, color = {0, 0, 127}));
  connect(regenThreshold.u, vArmature.y) annotation(
      Line(points = {{-24, -92}, {-8, -92}}, color = {0, 0, 127}));
  connect(KZero.y, brakeOrNot.u3) annotation(
      Line(points = {{-45, -128}, {-51, -128}, {-51, -100}, {-61, -100}}, color = {0, 0, 127}));
  connect(KRegen.y, brakeOrNot.u1) annotation(
      Line(points = {{-47, -60}, {-51, -60}, {-51, -84}, {-61, -84}}, color = {0, 0, 127}));
  connect(regenThreshold.y, brakeOrNot.u2) annotation(
      Line(points = {{-47, -92}, {-61, -92}}, color = {255, 0, 255}));
  connect(armSensorA.i, foCurrent.u) annotation(
      Line(points = {{80, -133}, {80, -113}}, color = {0, 0, 127}));
  connect(smooth.y, PID.u_s) annotation(
      Line(points = {{39, -64}, {68, -64}}, color = {0, 0, 127}));
  connect(switchArmature.y, smooth.u) annotation(
      Line(points = {{0, -39}, {0, -64}, {16, -64}}, color = {0, 0, 127}));
  connect(dcdc.dc_n2, armature_n) annotation(
      Line(points = {{106, -122}, {32, -122}, {32, -144}, {-62, -144}, {-62, -172}}, color = {0, 0, 255}));
  connect(PID.y, pwm.dutyCycle) annotation(
      Line(points = {{92, -64}, {134, -64}, {134, -94}, {128, -94}}, color = {0, 0, 127}));
  connect(batt_n, groundBatt.p) annotation(
      Line(points = {{170, 80}, {154, 80}, {154, 68}}, color = {0, 0, 255}));
  connect(batt_p, dcdc.dc_p1) annotation(
      Line(points = {{170, -82}, {152, -82}, {152, -134}, {126, -134}}, color = {0, 0, 255}));
  connect(dcdc.dc_n1, batt_n) annotation(
      Line(points = {{126, -122}, {144, -122}, {144, 80}, {170, 80}}, color = {0, 0, 255}));
  connect(accel, accelOnOff.u) annotation(
      Line(points = {{0, 186}, {0, 154}, {-18, 154}, {-18, 148}}, color = {0, 0, 127}));
  connect(brakeOrNot.y, switchArmature.u3) annotation(
      Line(points = {{-82, -92}, {-94, -92}, {-94, -72}, {-62, -72}, {-62, -38}, {-20, -38}, {-20, -6}, {-8, -6}, {-8, -16}}, color = {0, 0, 127}));
  connect(accel, gain.u) annotation(
      Line(points = {{0, 186}, {0, 144}, {12, 144}}, color = {0, 0, 127}));
  connect(gain.y, switchArmature.u1) annotation(
      Line(points = {{36, 144}, {134, 144}, {134, -8}, {8, -8}, {8, -16}}, color = {0, 0, 127}));
  connect(batt_p, field_p) annotation(
      Line(points = {{170, -82}, {152, -82}, {152, 8}, {-150, 8}, {-150, -80}, {-168, -80}}, color = {0, 0, 255}));
    annotation(
      defaultComponentName = "sepExPWM",
      Diagram(coordinateSystem(extent = {{-160, 160}, {160, -160}}))
  );
  end SepExPWMController;
end Controllers;