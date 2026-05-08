within Bartamod;

package Controllers "Custom motor controllers"
  extends Modelica.Icons.VariantsPackage;

  model SepExController
    parameter SI.Voltage voltage = 0 "System Voltage";
    parameter SI.Current current = 0 "System Current";
    parameter Boolean weakeningEnabled = true "Field-Weakening enabled";
    parameter SI.Voltage weakVoltage = 0 "Field-Weakening Voltage";
    Modelica.Blocks.Interfaces.RealInput accel "Accelerator (0..1)" annotation(
      Placement(transformation(origin = {0, 182}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
    Modelica.Electrical.Analog.Interfaces.PositivePin armature_p "Armature Positive pin" annotation(
      Placement(transformation(origin = {8, -166}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {40, -120}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin armature_n "Armature Negative pin" annotation(
      Placement(transformation(origin = {-72, -166}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-40, -120}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin field_p "Field Positive pin" annotation(
      Placement(transformation(origin = {-152, -40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-120, -40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin field_n "Field Negative pin" annotation(
      Placement(transformation(origin = {-152, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-120, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin batt_p "Battery Positive pin" annotation(
      Placement(transformation(origin = {166, -60}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {120, -40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin batt_n "Battery Negative pin" annotation(
      Placement(transformation(origin = {166, 62}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {120, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sources.SignalVoltage voltageArmature annotation(
      Placement(transformation(origin = {-58, -132}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Electrical.Analog.Sources.SignalVoltage voltageField annotation(
      Placement(transformation(origin = {-140, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain accelToAmps(k = current) annotation(
      Placement(transformation(origin = {48, 136}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Blocks.Continuous.LimPID PIArmature(Ni = 0.9, Ti = 0.2, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 2, yMax = 72, yMin = 0) annotation(
      Placement(transformation(origin = {12, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Blocks.Logical.Switch switch1 annotation(
      Placement(transformation(origin = {-44, 52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.RealToBoolean AccelOnOff(threshold = 0.01) annotation(
      Placement(transformation(origin = {-44, 136}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.Constant KVoltage(k = voltage) annotation(
      Placement(transformation(origin = {-20, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.Constant KRegenField(k = voltage*0.5) annotation(
      Placement(transformation(origin = {-66, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Logical.Switch switchArmature annotation(
      Placement(transformation(origin = {40, 78}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.Constant KRegen(k = -100) annotation(
      Placement(transformation(origin = {6, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Continuous.LimPID PIField(Ni = 0.9, Ti = 0.02, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 5, yMax = 72, yMin = 0) annotation(
      Placement(transformation(origin = {-116, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Nonlinear.SlewRateLimiter slewField(Rising = 10000, Falling = -40) annotation(
      Placement(transformation(origin = {-94, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Nonlinear.SlewRateLimiter slewArmature(Falling = -5000, Rising = 500) annotation(
      Placement(transformation(origin = {40, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    SepExFieldWeakening fieldWeakening(minV = weakVoltage, refThreshold = 2, timeThreshold = 1, kFW = 0.2, maxCorrection = 30, enabled = weakeningEnabled) annotation(
      Placement(transformation(origin = {-32, -26}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(transformation(origin = {-170, 22}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(transformation(origin = {-92, -160}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Ground ground11 annotation(
      Placement(transformation(origin = {174, 42}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation(
      Placement(transformation(origin = {140, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Add add annotation(
      Placement(transformation(origin = {92, -86}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    Modelica.Electrical.Analog.Sensors.MultiSensor sensorField annotation(
      Placement(transformation(origin = {-140, 24}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Sensors.MultiSensor sensorArmature annotation(
      Placement(transformation(origin = {-26, -132}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Electrical.Analog.Sensors.MultiSensor sensorBatt annotation(
      Placement(transformation(origin = {140, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Division realCurrent annotation(
      Placement(transformation(origin = {110, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Max max annotation(
      Placement(transformation(origin = {130, -86}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    Modelica.Blocks.Sources.Constant const1(k = 0.0001) annotation(
      Placement(transformation(origin = {124, -128}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Ground gnd annotation(
      Placement(transformation(origin = {108, 2}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Ground ground12 annotation(
      Placement(transformation(origin = {34, -132}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(accelToAmps.y, switchArmature.u1) annotation(
      Line(points = {{48, 125}, {48, 90}}, color = {0, 0, 127}));
    connect(KRegen.y, switchArmature.u3) annotation(
      Line(points = {{6, 89}, {6, 98}, {32, 98}, {32, 90}}, color = {0, 0, 127}));
    connect(KRegenField.y, switch1.u3) annotation(
      Line(points = {{-66, 81}, {-66, 72}, {-52, 72}, {-52, 64}}, color = {0, 0, 127}));
    connect(AccelOnOff.y, switch1.u2) annotation(
      Line(points = {{-44, 125}, {-44, 64}}, color = {255, 0, 255}));
    connect(AccelOnOff.y, switchArmature.u2) annotation(
      Line(points = {{-44, 125}, {-44, 118}, {40, 118}, {40, 90}}, color = {255, 0, 255}));
    connect(KVoltage.y, switch1.u1) annotation(
      Line(points = {{-20, 81}, {-20, 76}, {-36, 76}, {-36, 64}}, color = {0, 0, 127}));
    connect(switchArmature.y, slewArmature.u) annotation(
      Line(points = {{40, 67}, {40, 52}}, color = {0, 0, 127}));
    connect(PIArmature.y, voltageArmature.v) annotation(
      Line(points = {{12, -61}, {12, -64}, {-58, -64}, {-58, -120}}, color = {0, 0, 127}));
    connect(slewArmature.y, PIArmature.u_s) annotation(
      Line(points = {{40, 29}, {40, -11}, {12, -11}, {12, -38}}, color = {0, 0, 127}));
    connect(slewField.y, PIField.u_s) annotation(
      Line(points = {{-105, -58}, {-116, -58}, {-116, -42}}, color = {0, 0, 127}));
    connect(PIField.y, voltageField.v) annotation(
      Line(points = {{-116, -19}, {-116, 0}, {-128, 0}}, color = {0, 0, 127}));
    connect(PIArmature.y, fieldWeakening.u_arm) annotation(
      Line(points = {{12, -61}, {12, -64}, {-38, -64}, {-38, -38}}, color = {0, 0, 127}));
    connect(slewArmature.y, fieldWeakening.desired_i) annotation(
      Line(points = {{40, 29}, {40, -46}, {-26, -46}, {-26, -38}}, color = {0, 0, 127}));
    connect(switch1.y, fieldWeakening.u) annotation(
      Line(points = {{-44, 41}, {-44, -2}, {22, -2}, {22, -26}, {-20, -26}}, color = {0, 0, 127}));
    connect(fieldWeakening.y, slewField.u) annotation(
      Line(points = {{-43, -26}, {-72, -26}, {-72, -58}, {-82, -58}}, color = {0, 0, 127}));
    connect(ground.p, field_n) annotation(
      Line(points = {{-170, 32}, {-170, 36}, {-152, 36}, {-152, 40}}, color = {0, 0, 255}));
    connect(armature_n, ground1.p) annotation(
      Line(points = {{-72, -166}, {-72, -142}, {-92, -142}, {-92, -150}}, color = {0, 0, 255}));
    connect(voltageArmature.n, armature_n) annotation(
      Line(points = {{-68, -132}, {-72, -132}, {-72, -166}}, color = {0, 0, 255}));
    connect(voltageField.p, field_p) annotation(
      Line(points = {{-140, -10}, {-140, -40}, {-152, -40}}, color = {0, 0, 255}));
    connect(field_n, sensorField.pc) annotation(
      Line(points = {{-152, 40}, {-140, 40}, {-140, 34}}, color = {0, 0, 255}));
    connect(sensorField.nc, voltageField.n) annotation(
      Line(points = {{-140, 14}, {-140, 10}}, color = {0, 0, 255}));
    connect(sensorField.v, PIField.u_m) annotation(
      Line(points = {{-129, 18}, {-99, 18}, {-99, -30}, {-105, -30}}, color = {0, 0, 127}));
    connect(sensorArmature.nc, armature_p) annotation(
      Line(points = {{-16, -132}, {8, -132}, {8, -166}}, color = {0, 0, 255}));
    connect(voltageArmature.p, sensorArmature.pc) annotation(
      Line(points = {{-48, -132}, {-36, -132}}, color = {0, 0, 255}));
    connect(sensorArmature.i, fieldWeakening.measured_i) annotation(
      Line(points = {{-32, -121}, {-32, -38}}, color = {0, 0, 127}));
    connect(sensorArmature.i, PIArmature.u_m) annotation(
      Line(points = {{-32, -121}, {-32, -71}, {34, -71}, {34, -51}, {24, -51}}, color = {0, 0, 127}));
    connect(batt_n, ground11.p) annotation(
      Line(points = {{166, 62}, {174, 62}, {174, 52}}, color = {0, 0, 255}));
    connect(signalCurrent.p, batt_p) annotation(
      Line(points = {{140, -36}, {140, -60}, {166, -60}}, color = {0, 0, 255}));
    connect(sensorBatt.nc, signalCurrent.n) annotation(
      Line(points = {{140, -8}, {140, -16}}, color = {0, 0, 255}));
    connect(sensorBatt.pc, batt_n) annotation(
      Line(points = {{140, 12}, {140, 62}, {166, 62}}, color = {0, 0, 255}));
    connect(sensorBatt.pv, signalCurrent.p) annotation(
      Line(points = {{150, 2}, {150, -36}, {140, -36}}, color = {0, 0, 255}));
    connect(gnd.p, sensorBatt.nv) annotation(
      Line(points = {{114, 2}, {130, 2}}, color = {0, 0, 255}));
    connect(realCurrent.y, signalCurrent.i) annotation(
      Line(points = {{110, -36}, {110, -26}, {128, -26}}, color = {0, 0, 127}));
    connect(max.y, realCurrent.u2) annotation(
      Line(points = {{130, -74}, {130, -68}, {116, -68}, {116, -60}}, color = {0, 0, 127}));
    connect(add.y, realCurrent.u1) annotation(
      Line(points = {{92, -74}, {92, -68}, {104, -68}, {104, -60}}, color = {0, 0, 127}));
    connect(max.u2, const1.y) annotation(
      Line(points = {{124, -98}, {124, -117}}, color = {0, 0, 127}));
    connect(sensorBatt.v, max.u1) annotation(
      Line(points = {{130, -4}, {74, -4}, {74, -148}, {136, -148}, {136, -98}}, color = {0, 0, 127}));
    connect(sensorArmature.power, add.u1) annotation(
      Line(points = {{-36, -126}, {-38, -126}, {-38, -110}, {98, -110}, {98, -98}}, color = {0, 0, 127}));
    connect(sensorField.power, add.u2) annotation(
      Line(points = {{-134, 36}, {62, 36}, {62, -106}, {86, -106}, {86, -98}}, color = {0, 0, 127}));
    connect(sensorArmature.pv, armature_p) annotation(
      Line(points = {{-26, -142}, {-26, -150}, {8, -150}, {8, -166}}, color = {0, 0, 255}));
    connect(sensorArmature.nv, ground12.p) annotation(
      Line(points = {{-26, -122}, {-26, -118}, {34, -118}, {34, -122}}, color = {0, 0, 255}));
    connect(sensorField.pv, voltageField.p) annotation(
      Line(points = {{-150, 24}, {-152, 24}, {-152, -10}, {-140, -10}}, color = {0, 0, 255}));
    connect(sensorField.nv, field_n) annotation(
      Line(points = {{-130, 24}, {-120, 24}, {-120, 40}, {-152, 40}}, color = {0, 0, 255}));
    connect(accel, accelToAmps.u) annotation(
      Line(points = {{0, 182}, {0, 156}, {48, 156}, {48, 148}}, color = {0, 0, 127}));
  connect(accel, AccelOnOff.u) annotation(
      Line(points = {{0, 182}, {0, 156}, {-44, 156}, {-44, 148}}, color = {0, 0, 127}));
    annotation(
      defaultComponentName = "sepEx",
      Diagram(coordinateSystem(extent = {{-160, 160}, {160, -160}})),
      Icon(coordinateSystem(extent = {{-130, -130}, {130, 130}}), graphics = {// Cuerpo del controlador (proporción cuadrada 120x120 relativa)
      Rectangle(extent = {{-90, 90}, {90, -90}}, lineColor = {0, 0, 0}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, lineThickness = 0.5), Ellipse(extent = {{-89, 40}, {-69, 20}}, lineColor = {0, 0, 255}), Ellipse(extent = {{-89, 20}, {-69, 0}}, lineColor = {0, 0, 255}), Ellipse(extent = {{-89, 0}, {-69, -20}}, lineColor = {0, 0, 255}), Ellipse(extent = {{-89, -20}, {-69, -40}}, lineColor = {0, 0, 255}), Rectangle(extent = {{-89, 40}, {-79, -40}}, lineColor = {230, 230, 230}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, lineThickness = 0.5), Line(points = {{-120, 40}, {-80, 40}}, color = {0, 0, 255}), Line(points = {{-120, -40}, {-80, -40}}, color = {0, 0, 255}), Line(points = {{-40, -120}, {-40, -90}}, color = {0, 0, 255}), Line(points = {{40, -120}, {40, -90}}, color = {0, 0, 255}), Text(extent = {{-150, 70}, {150, 55}}, textColor = {0, 0, 255}, textString = "%name")}));
  end SepExController;

  model SepExFieldWeakening
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Boolean enabled = true "Enabled";
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
    Modelica.Blocks.Logical.And weakeningOn annotation(
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
    Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(Rising = 20, Falling = -5000) annotation(
      Placement(transformation(origin = {-38, -70}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1, uMin = 0) annotation(
      Placement(transformation(origin = {44, -70}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Logical.And weakeningActive annotation(
      Placement(transformation(origin = {18, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.BooleanConstant isEnabled(k = enabled) annotation(
      Placement(transformation(origin = {50, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  equation
    connect(abs1.y, uIsConstant.u) annotation(
      Line(points = {{-35, 18}, {-28, 18}}, color = {0, 0, 127}));
    connect(u, swOutput.u3) annotation(
      Line(points = {{-120, 0}, {-34, 0}, {-34, -16}, {48, -16}}, color = {0, 0, 127}));
    connect(swOutput.y, y) annotation(
      Line(points = {{71, -24}, {92, -24}, {92, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(derivative.y, abs1.u) annotation(
      Line(points = {{-65, 18}, {-59, 18}}, color = {0, 0, 127}));
    connect(u_arm, VuThreshold.u) annotation(
      Line(points = {{-50, 120}, {-50, 96}, {-96, 96}, {-96, 54}, {-90, 54}}, color = {0, 0, 127}));
    connect(u_arm, derivative.u) annotation(
      Line(points = {{-50, 120}, {-50, 96}, {-96, 96}, {-96, 18}, {-88, 18}}, color = {0, 0, 127}));
    connect(uIsConstant.y, weakeningOn.u2) annotation(
      Line(points = {{-4, 18}, {0, 18}, {0, 40}, {-32, 40}, {-32, 46}, {-26, 46}}, color = {255, 0, 255}));
    connect(measured_i, feedbackArrmature.u2) annotation(
      Line(points = {{0, 120}, {0, 94}, {26, 94}, {26, 88}}, color = {0, 0, 127}));
    connect(desired_i, feedbackArrmature.u1) annotation(
      Line(points = {{50, 120}, {50, 80}, {34, 80}}, color = {0, 0, 127}));
    connect(weakeningOn.y, swAvoidZero.u2) annotation(
      Line(points = {{-2, 54}, {10, 54}, {10, 40}, {30, 40}}, color = {255, 0, 255}));
    connect(desired_i, swAvoidZero.u1) annotation(
      Line(points = {{50, 120}, {50, 66}, {22, 66}, {22, 48}, {30, 48}}, color = {0, 0, 127}));
    connect(u, excess.u1) annotation(
      Line(points = {{-120, 0}, {-70, 0}, {-70, -34}, {-48, -34}}, color = {0, 0, 127}));
    connect(excess.y, swOutput.u1) annotation(
      Line(points = {{-24, -40}, {0, -40}, {0, -32}, {48, -32}}, color = {0, 0, 127}));
    connect(slewRateLimiter.y, excess.u2) annotation(
      Line(points = {{-49, -70}, {-60, -70}, {-60, -46}, {-48, -46}}, color = {0, 0, 127}));
    connect(swAvoidZero.y, rateCorrection.u2) annotation(
      Line(points = {{54, 40}, {58, 40}, {58, 48}, {64, 48}}, color = {0, 0, 127}));
    connect(feedbackArrmature.y, rateCorrection.u1) annotation(
      Line(points = {{18, 80}, {16, 80}, {16, 60}, {64, 60}}, color = {0, 0, 127}));
    connect(VuThreshold.y, weakeningOn.u1) annotation(
      Line(points = {{-66, 54}, {-26, 54}}, color = {255, 0, 255}));
    connect(feedbackArrmature.y, swAvoidZero.u3) annotation(
      Line(points = {{18, 80}, {16, 80}, {16, 32}, {30, 32}}, color = {0, 0, 127}));
    connect(gain.y, slewRateLimiter.u) annotation(
      Line(points = {{-8, -70}, {-26, -70}}, color = {0, 0, 127}));
    connect(limiter.y, gain.u) annotation(
      Line(points = {{34, -70}, {14, -70}}, color = {0, 0, 127}));
    connect(rateCorrection.y, limiter.u) annotation(
      Line(points = {{88, 54}, {92, 54}, {92, 16}, {80, 16}, {80, -70}, {56, -70}}, color = {0, 0, 127}));
    connect(weakeningOn.y, weakeningActive.u2) annotation(
      Line(points = {{-2, 54}, {10, 54}, {10, 14}}, color = {255, 0, 255}));
    connect(isEnabled.y, weakeningActive.u1) annotation(
      Line(points = {{50, 14}, {50, 22}, {18, 22}, {18, 14}}, color = {255, 0, 255}));
    connect(weakeningActive.y, swOutput.u2) annotation(
      Line(points = {{18, -8}, {18, -24}, {48, -24}}, color = {255, 0, 255}));
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
    Modelica.Electrical.PowerConverters.DCDC.HBridge armHBridge(RonDiode = 0.001, RonTransistor = 0.001, constantEnable = true, useConstantEnable = true) annotation(
      Placement(transformation(origin = {116, -128}, extent = {{10, 10}, {-10, -10}})));
    Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM armPWM(commonComparison = true, f = 10000, refType = Modelica.Electrical.PowerConverters.Types.SingleReferenceType.Sawtooth, useConstantDutyCycle = false) annotation(
      Placement(transformation(origin = {116, -94}, extent = {{10, 10}, {-10, -10}})));
    Modelica.Blocks.Continuous.LimPID PIArmature(Ni = 0.9, Ti = 0.1, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.03, yMax = 0.9, yMin = -0.9) annotation(
      Placement(transformation(origin = {80, -64}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor armSensorV annotation(
      Placement(transformation(origin = {48, -144}, extent = {{-10, -10}, {10, 10}}, rotation = -180)));
    Modelica.Blocks.Continuous.FirstOrder armCurrentFo(T = 0.0001) annotation(
      Placement(transformation(origin = {80, -100}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Mean armVoltageMean(f = 10000) annotation(
      Placement(transformation(origin = {2, -92}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Math.Gain gain(k = current) annotation(
      Placement(transformation(origin = {24, 150}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.RealToBoolean accelOnOff(threshold = 0.01) annotation(
      Placement(transformation(origin = {-14, 144}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Logical.Switch switchArmature annotation(
      Placement(transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.Constant KRegen(k = -1*regenCurrent) annotation(
      Placement(transformation(origin = {-36, -60}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Nonlinear.SlewRateLimiter armSmooth(Falling = -5000, Rising = 500) annotation(
      Placement(transformation(origin = {28, -64}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Logical.Switch brakeOrNot annotation(
      Placement(transformation(origin = {-72, -92}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Logical.GreaterThreshold regenThreshold(threshold = 3) annotation(
      Placement(transformation(origin = {-36, -92}, extent = {{-10, -10}, {10, 10}}, rotation = -180)));
    Modelica.Blocks.Sources.Constant KZero(k = 0) annotation(
      Placement(transformation(origin = {-34, -128}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Electrical.PowerConverters.DCDC.HBridge fieldHBrige(RonDiode = 0.001, RonTransistor = 0.001, constantEnable = true, useConstantEnable = true) annotation(
      Placement(transformation(origin = {-70, 66}, extent = {{10, 10}, {-10, -10}})));
    Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM fieldPWM(commonComparison = true, f = 10000, refType = Modelica.Electrical.PowerConverters.Types.SingleReferenceType.Sawtooth, useConstantDutyCycle = false) annotation(
      Placement(transformation(origin = {-70, 100}, extent = {{10, 10}, {-10, -10}})));
    Modelica.Blocks.Math.Mean fieldVoltageMean(f = 10000) annotation(
      Placement(transformation(origin = {-128, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Continuous.LimPID PIField(Ni = 0.9, Ti = 0.02, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 5, yMax = 1, yMin = 0) annotation(
      Placement(transformation(origin = {-32, 100}, extent = {{10, 10}, {-10, -10}})));
    Modelica.Blocks.Math.Division fieldBatRate annotation(
      Placement(transformation(origin = {-96, 126}, extent = {{-10, 10}, {10, -10}})));
    Modelica.Blocks.Logical.GreaterThreshold fieldCurrentThreshold(threshold = current/2) annotation(
      Placement(transformation(origin = {80, 38}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant KMinField(k = 0.1) annotation(
      Placement(transformation(origin = {46, 38}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Logical.Switch swField2 annotation(
      Placement(transformation(origin = {4, 100}, extent = {{10, 10}, {-10, -10}})));
    Modelica.Blocks.Sources.Constant KFieldRegen(k = 0.6) annotation(
      Placement(transformation(origin = {110, 90}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Logical.Switch swField1 annotation(
      Placement(transformation(origin = {76, 108}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Sources.Constant KMaxField(k = 1) annotation(
      Placement(transformation(origin = {108, 124}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Nonlinear.SlewRateLimiter fieldSmooth(Falling = -40, Rising = 10000) annotation(
      Placement(transformation(origin = {46, 108}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Electrical.Analog.Basic.Ground gndFieldHIn annotation(
      Placement(transformation(origin = {-6, 62}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor batSensorV annotation(
      Placement(transformation(origin = {-28, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor fieldSensorV annotation(
      Placement(transformation(origin = {-106, 70}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Mean batVoltageMean(f = 10000) annotation(
      Placement(transformation(origin = {-68, 28}, extent = {{-10, 10}, {10, -10}}, rotation = -180)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor fieldSensorA annotation(
      Placement(transformation(origin = {-124, 50}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(transformation(origin = {-28, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.FirstOrder fieldCurrentFo(T = 0.0001) annotation(
      Placement(transformation(origin = {-106, -30}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant KNoDivZ(k = 0.1) annotation(
      Placement(transformation(origin = {-68, -2}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Math.Max max annotation(
      Placement(transformation(origin = {-104, 22}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    Modelica.Blocks.Logical.And and1 annotation(
      Placement(transformation(origin = {46, 74}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    Modelica.Blocks.Logical.Not not1 annotation(
      Placement(transformation(origin = {80, 74}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  equation
    connect(field_n, groundField.p) annotation(
      Line(points = {{-168, 80}, {-160, 80}, {-160, 72}}, color = {0, 0, 255}));
    connect(armPWM.fire, armHBridge.fire_p) annotation(
      Line(points = {{122, -105}, {122, -116}}, color = {255, 0, 255}));
    connect(armPWM.notFire, armHBridge.fire_n) annotation(
      Line(points = {{110, -105}, {110, -116}}, color = {255, 0, 255}));
    connect(armSensorV.p, armature_p) annotation(
      Line(points = {{58, -144}, {62, -144}, {62, -172}}, color = {0, 0, 255}));
    connect(armSensorV.n, armature_n) annotation(
      Line(points = {{38, -144}, {-62, -144}, {-62, -172}}, color = {0, 0, 255}));
    connect(armCurrentFo.y, PIArmature.u_m) annotation(
      Line(points = {{80, -89}, {80, -76}}, color = {0, 0, 127}));
    connect(armSensorV.p, armSensorA.n) annotation(
      Line(points = {{58, -144}, {70, -144}}, color = {0, 0, 255}));
    connect(armHBridge.dc_p2, armSensorA.p) annotation(
      Line(points = {{106, -134}, {102, -134}, {102, -144}, {90, -144}}, color = {0, 0, 255}));
    connect(armVoltageMean.u, armSensorV.v) annotation(
      Line(points = {{14, -92}, {48, -92}, {48, -133}}, color = {0, 0, 127}));
    connect(regenThreshold.u, armVoltageMean.y) annotation(
      Line(points = {{-24, -92}, {-8, -92}}, color = {0, 0, 127}));
    connect(KZero.y, brakeOrNot.u3) annotation(
      Line(points = {{-45, -128}, {-51, -128}, {-51, -100}, {-61, -100}}, color = {0, 0, 127}));
    connect(KRegen.y, brakeOrNot.u1) annotation(
      Line(points = {{-47, -60}, {-51, -60}, {-51, -84}, {-61, -84}}, color = {0, 0, 127}));
    connect(regenThreshold.y, brakeOrNot.u2) annotation(
      Line(points = {{-47, -92}, {-61, -92}}, color = {255, 0, 255}));
    connect(armSensorA.i, armCurrentFo.u) annotation(
      Line(points = {{80, -133}, {80, -113}}, color = {0, 0, 127}));
    connect(armSmooth.y, PIArmature.u_s) annotation(
      Line(points = {{39, -64}, {68, -64}}, color = {0, 0, 127}));
    connect(switchArmature.y, armSmooth.u) annotation(
      Line(points = {{0, -39}, {0, -64}, {16, -64}}, color = {0, 0, 127}));
    connect(armHBridge.dc_n2, armature_n) annotation(
      Line(points = {{106, -122}, {32, -122}, {32, -144}, {-62, -144}, {-62, -172}}, color = {0, 0, 255}));
    connect(PIArmature.y, armPWM.dutyCycle) annotation(
      Line(points = {{92, -64}, {134, -64}, {134, -94}, {128, -94}}, color = {0, 0, 127}));
    connect(batt_n, groundBatt.p) annotation(
      Line(points = {{170, 80}, {154, 80}, {154, 68}}, color = {0, 0, 255}));
    connect(batt_p, armHBridge.dc_p1) annotation(
      Line(points = {{170, -82}, {152, -82}, {152, -134}, {126, -134}}, color = {0, 0, 255}));
    connect(armHBridge.dc_n1, batt_n) annotation(
      Line(points = {{126, -122}, {144, -122}, {144, 80}, {170, 80}}, color = {0, 0, 255}));
    connect(brakeOrNot.y, switchArmature.u3) annotation(
      Line(points = {{-82, -92}, {-94, -92}, {-94, -72}, {-62, -72}, {-62, -38}, {-20, -38}, {-20, -6}, {-8, -6}, {-8, -16}}, color = {0, 0, 127}));
    connect(accel, gain.u) annotation(
      Line(points = {{0, 186}, {0, 150}, {12, 150}}, color = {0, 0, 127}));
    connect(gain.y, switchArmature.u1) annotation(
      Line(points = {{36, 150}, {134, 150}, {134, -6}, {8, -6}, {8, -16}}, color = {0, 0, 127}));
    connect(fieldPWM.notFire, fieldHBrige.fire_n) annotation(
      Line(points = {{-76, 89}, {-76, 77}}, color = {255, 0, 255}));
    connect(fieldPWM.fire, fieldHBrige.fire_p) annotation(
      Line(points = {{-64, 89}, {-64, 77}}, color = {255, 0, 255}));
    connect(PIField.y, fieldPWM.dutyCycle) annotation(
      Line(points = {{-43, 100}, {-58, 100}}, color = {0, 0, 127}));
    connect(KMinField.y, swField2.u1) annotation(
      Line(points = {{35, 38}, {23, 38}, {23, 92}, {15, 92}}, color = {0, 0, 127}));
    connect(swField2.y, PIField.u_s) annotation(
      Line(points = {{-7, 100}, {-21, 100}}, color = {0, 0, 127}));
    connect(swField1.y, fieldSmooth.u) annotation(
      Line(points = {{65, 108}, {58, 108}}, color = {0, 0, 127}));
    connect(fieldSmooth.y, swField2.u3) annotation(
      Line(points = {{35, 108}, {16, 108}}, color = {0, 0, 127}));
    connect(KMaxField.y, swField1.u1) annotation(
      Line(points = {{97, 124}, {92.5, 124}, {92.5, 116}, {88, 116}}, color = {0, 0, 127}));
    connect(fieldBatRate.y, PIField.u_m) annotation(
      Line(points = {{-85, 126}, {-32, 126}, {-32, 112}}, color = {0, 0, 127}));
    connect(fieldHBrige.dc_n1, gndFieldHIn.p) annotation(
      Line(points = {{-60, 72}, {-6, 72}}, color = {0, 0, 255}));
    connect(fieldSensorV.v, fieldVoltageMean.u) annotation(
      Line(points = {{-117, 70}, {-128, 70}, {-128, 90}}, color = {0, 0, 127}));
    connect(batSensorV.v, batVoltageMean.u) annotation(
      Line(points = {{-39, 28}, {-56, 28}}, color = {0, 0, 127}));
    connect(fieldVoltageMean.y, fieldBatRate.u1) annotation(
      Line(points = {{-128, 113}, {-128, 120}, {-108, 120}}, color = {0, 0, 127}));
    connect(fieldSensorV.n, fieldHBrige.dc_n2) annotation(
      Line(points = {{-106, 80}, {-90, 80}, {-90, 72}, {-80, 72}}, color = {0, 0, 255}));
    connect(fieldHBrige.dc_p2, fieldSensorA.p) annotation(
      Line(points = {{-80, 60}, {-90, 60}, {-90, 50}, {-114, 50}}, color = {0, 0, 255}));
    connect(fieldSensorV.p, fieldSensorA.p) annotation(
      Line(points = {{-106, 60}, {-106, 50}, {-114, 50}}, color = {0, 0, 255}));
    connect(fieldHBrige.dc_p1, batSensorV.p) annotation(
      Line(points = {{-60, 60}, {-28, 60}, {-28, 38}}, color = {0, 0, 255}));
    connect(batSensorV.n, ground.p) annotation(
      Line(points = {{-28, 18}, {-28, 12}}, color = {0, 0, 255}));
    connect(fieldSensorA.i, fieldCurrentFo.u) annotation(
      Line(points = {{-124, 39}, {-124, -30}, {-118, -30}}, color = {0, 0, 127}));
    connect(KFieldRegen.y, swField1.u3) annotation(
      Line(points = {{99, 90}, {94, 90}, {94, 100}, {88, 100}}, color = {0, 0, 127}));
    connect(accelOnOff.u, accel) annotation(
      Line(points = {{-14, 156}, {-14, 160}, {0, 160}, {0, 186}}, color = {0, 0, 127}));
    connect(accelOnOff.y, switchArmature.u2) annotation(
      Line(points = {{-14, 134}, {-14, 128}, {42, 128}, {42, 146}, {130, 146}, {130, 0}, {0, 0}, {0, -16}}, color = {255, 0, 255}));
    connect(accelOnOff.y, swField1.u2) annotation(
      Line(points = {{-14, 134}, {-14, 128}, {42, 128}, {42, 146}, {130, 146}, {130, 108}, {88, 108}}, color = {255, 0, 255}));
    connect(batt_p, batSensorV.p) annotation(
      Line(points = {{170, -82}, {152, -82}, {152, 12}, {0, 12}, {0, 42}, {-28, 42}, {-28, 38}}, color = {0, 0, 255}));
    connect(fieldSensorA.n, field_p) annotation(
      Line(points = {{-134, 50}, {-144, 50}, {-144, -80}, {-168, -80}}, color = {0, 0, 255}));
    connect(fieldSensorV.n, field_n) annotation(
      Line(points = {{-106, 80}, {-168, 80}}, color = {0, 0, 255}));
    connect(batVoltageMean.y, max.u1) annotation(
      Line(points = {{-78, 28}, {-92, 28}}, color = {0, 0, 127}));
    connect(KNoDivZ.y, max.u2) annotation(
      Line(points = {{-78, -2}, {-84, -2}, {-84, 16}, {-92, 16}}, color = {0, 0, 127}));
    connect(max.y, fieldBatRate.u2) annotation(
      Line(points = {{-114, 22}, {-150, 22}, {-150, 132}, {-108, 132}}, color = {0, 0, 127}));
    connect(armCurrentFo.y, fieldCurrentThreshold.u) annotation(
      Line(points = {{80, -88}, {80, -84}, {98, -84}, {98, 38}, {92, 38}}, color = {0, 0, 127}));
    connect(fieldCurrentThreshold.y, and1.u2) annotation(
      Line(points = {{69, 38}, {64, 38}, {64, 66}, {58, 66}}, color = {255, 0, 255}));
    connect(and1.y, swField2.u2) annotation(
      Line(points = {{35, 74}, {30, 74}, {30, 100}, {16, 100}}, color = {255, 0, 255}));
    connect(and1.u1, not1.y) annotation(
      Line(points = {{58, 74}, {70, 74}}, color = {255, 0, 255}));
    connect(accelOnOff.y, not1.u) annotation(
      Line(points = {{-14, 134}, {-14, 128}, {42, 128}, {42, 146}, {130, 146}, {130, 74}, {92, 74}}, color = {255, 0, 255}));
    annotation(
      defaultComponentName = "sepExPWM",
      Diagram(coordinateSystem(extent = {{-160, 160}, {160, -160}})),
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
  end SepExPWMController;
end Controllers;