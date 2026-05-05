within Bartamod;
package Controllers "Custom motor controllers"
    extends Modelica.Icons.VariantsPackage;
  model SepExController
      parameter SI.Voltage voltage = 0 "System Voltage";
      parameter SI.Current current = 0 "System Current";
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
      Modelica.Electrical.Analog.Sources.SignalVoltage voltageArmature annotation(
          Placement(transformation(origin = {-26, -86}, extent = {{10, -10}, {-10, 10}})));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentArmature annotation(
          Placement(transformation(origin = {0, -86}, extent = {{-10, 10}, {10, -10}})));
      Modelica.Electrical.Analog.Sources.SignalVoltage voltageField annotation(
          Placement(transformation(origin = {-108, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Gain gain(k = current) annotation(
          Placement(transformation(origin = {68, 84}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Blocks.Continuous.LimPID PIArmature(Ni = 0.9, Ti = 0.2, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 2, yMax = 72, yMin = 0) annotation(
          Placement(transformation(origin = {60, -48}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Blocks.Logical.Switch switch1 annotation(
          Placement(transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.RealToBoolean AccelOnOff(threshold = 0.01)  annotation(
          Placement(transformation(origin = {-40, 96}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant KVoltage(k = voltage)  annotation(
          Placement(transformation(origin = {-14, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant KRegenField(k = voltage*0.5) annotation(
          Placement(transformation(origin = {-62, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Logical.Switch switchArmature annotation(
          Placement(transformation(origin = {60, 42}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant KRegen(k = -100) annotation(
          Placement(transformation(origin = {26, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Continuous.LimPID PIField(Ni = 0.9, Ti = 0.02, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 5, yMax = 72, yMin = 0) annotation(
          Placement(transformation(origin = {-40, -46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Nonlinear.SlewRateLimiter slewField(Rising = 10000, Falling = -40) annotation(
      Placement(transformation(origin = {-40, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(
      Placement(transformation(origin = {-70, 0}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  Modelica.Blocks.Nonlinear.SlewRateLimiter slewArmature(Falling = -5000, Rising = 500) annotation(
      Placement(transformation(origin = {60, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
    connect(voltageArmature.n, armature_n) annotation(
      Line(points = {{-36, -86}, {-40, -86}, {-40, -120}}, color = {0, 0, 255}));
    connect(voltageArmature.p, currentArmature.p) annotation(
      Line(points = {{-16, -86}, {-10, -86}}, color = {0, 0, 255}));
    connect(currentArmature.n, armature_p) annotation(
      Line(points = {{10, -86}, {40, -86}, {40, -120}}, color = {0, 0, 255}));
    connect(accel, gain.u) annotation(
      Line(points = {{0, 120}, {68, 120}, {68, 96}}, color = {0, 0, 127}));
    connect(gain.y, switchArmature.u1) annotation(
      Line(points = {{68, 73}, {68, 54}}, color = {0, 0, 127}));
    connect(KRegen.y, switchArmature.u3) annotation(
      Line(points = {{26, 53}, {26, 62}, {52, 62}, {52, 54}}, color = {0, 0, 127}));
    connect(accel, AccelOnOff.u) annotation(
      Line(points = {{0, 120}, {-40, 120}, {-40, 108}}, color = {0, 0, 127}));
    connect(KRegenField.y, switch1.u3) annotation(
      Line(points = {{-62, 49}, {-62, 40}, {-48, 40}, {-48, 32}}, color = {0, 0, 127}));
    connect(AccelOnOff.y, switch1.u2) annotation(
      Line(points = {{-40, 85}, {-40, 32}}, color = {255, 0, 255}));
    connect(AccelOnOff.y, switchArmature.u2) annotation(
      Line(points = {{-40, 85}, {-40, 74}, {60, 74}, {60, 54}}, color = {255, 0, 255}));
    connect(switch1.y, slewField.u) annotation(
      Line(points = {{-40, 9}, {-40, -2}}, color = {0, 0, 127}));
    connect(slewField.y, PIField.u_s) annotation(
      Line(points = {{-40, -25}, {-40, -34}}, color = {0, 0, 127}));
    connect(currentArmature.i, PIArmature.u_m) annotation(
      Line(points = {{0, -74}, {0, -68}, {80, -68}, {80, -48}, {72, -48}}, color = {0, 0, 127}));
    connect(KVoltage.y, switch1.u1) annotation(
      Line(points = {{-14, 49}, {-14, 44}, {-32, 44}, {-32, 32}}, color = {0, 0, 127}));
    connect(voltageField.p, field_p) annotation(
      Line(points = {{-108, -10}, {-108, -40}, {-120, -40}}, color = {0, 0, 255}));
    connect(voltageField.n, field_n) annotation(
      Line(points = {{-108, 10}, {-108, 40}, {-120, 40}}, color = {0, 0, 255}));
  connect(voltageSensor.n, voltageField.n) annotation(
      Line(points = {{-70, 10}, {-108, 10}}, color = {0, 0, 255}));
  connect(voltageSensor.p, voltageField.p) annotation(
      Line(points = {{-70, -10}, {-108, -10}}, color = {0, 0, 255}));
  connect(voltageSensor.v, PIField.u_m) annotation(
      Line(points = {{-58, 0}, {-56, 0}, {-56, -46}, {-52, -46}}, color = {0, 0, 127}));
  connect(PIField.y, voltageField.v) annotation(
      Line(points = {{-40, -56}, {-40, -60}, {-92, -60}, {-92, 0}, {-96, 0}}, color = {0, 0, 127}));
  connect(switchArmature.y, slewArmature.u) annotation(
      Line(points = {{60, 32}, {60, -2}}, color = {0, 0, 127}));
  connect(slewArmature.y, PIArmature.u_s) annotation(
      Line(points = {{60, -24}, {60, -36}}, color = {0, 0, 127}));
  connect(PIArmature.y, voltageArmature.v) annotation(
      Line(points = {{60, -58}, {60, -64}, {-26, -64}, {-26, -74}}, color = {0, 0, 127}));
    annotation(
          defaultComponentName="sepEx",
          Diagram(coordinateSystem(extent = {{-120, 120}, {120, -120}})),
          Icon(coordinateSystem(extent={{-130,-130},{130,130}}), 
          graphics={
            // Cuerpo del controlador (proporción cuadrada 120x120 relativa)
            Rectangle(
              extent={{-90,90},{90,-90}},
              lineColor={0,0,0},
              fillColor={230,230,230},
              fillPattern=FillPattern.Solid,
              lineThickness=0.5),
              Ellipse(extent={{-89,40},{-69,20}}, lineColor={0,0,255}),
              Ellipse(extent={{-89,20},{-69,0}}, lineColor={0,0,255}),
              Ellipse(extent={{-89,0},{-69,-20}}, lineColor={0,0,255}),
              Ellipse(extent={{-89,-20},{-69,-40}}, lineColor={0,0,255}),
              Rectangle(
                  extent={{-89,40},{-79,-40}},
                  lineColor={230,230,230},
                  fillColor={230,230,230},
                  fillPattern=FillPattern.Solid,lineThickness=0.5),
            Line(points={{-120,40},{-80,40}},   color={0,0,255}),
            Line(points={{-120,-40},{-80,-40}},   color={0,0,255}),
            Line(points={{-40,-120},{-40,-90}},   color={0,0,255}),
            Line(points={{40,-120},{40,-90}},   color={0,0,255}),
            Text(
            extent={{-150,70},{150,55}},
            textColor={0,0,255},
            textString="%name")
          })
    );
  end SepExController;
end Controllers;