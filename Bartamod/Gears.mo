within Bartamod;
package Gears "Custom motor controllers"
     extends Modelica.Mechanics.Rotational.Icons.Gear;

    model IdealGearSignal "Ideal gear without inertia with ratio as signal"
        extends Modelica.Mechanics.Rotational.Icons.Gear;
        extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
        Modelica.Blocks.Interfaces.RealInput ratio "Gear Ratio as input signal" annotation(
            Placement(transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
        SI.Angle phi_a "Angle between left shaft flange and support";
        SI.Angle phi_b "Angle between right shaft flange and support";
        equation
        phi_a = flange_a.phi - phi_support;
        phi_b = flange_b.phi - phi_support;
        phi_a = ratio*phi_b;
        0 = ratio*flange_a.tau + flange_b.tau;
        annotation(
            Documentation(info = "<html>
        <p>
        This element characterizes any type of gear box which is fixed in the
        ground and which has one driving shaft and one driven shaft.
        The gear is <strong>ideal</strong>, i.e., it does not have inertia, elasticity, damping
        or backlash. If these effects have to be considered, the gear has to be
        connected to other elements in an appropriate way.
        </p>

        </html>"),
            Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-153, 145}, {147, 105}}, textColor = {0, 0, 255}, textString = "%name"), Text(extent = {{-146, -49}, {154, -79}}, textString = "ratio=%ratio")}));
    end IdealGearSignal;

    model VariableRatioGear
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(
            Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(
            Placement(transformation(extent = {{90, -10}, {110, 10}})));
        Modelica.Blocks.Interfaces.RealInput ratio annotation(
            Placement(transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
        equation
        flange_a.phi = flange_b.phi*ratio;
        flange_b.tau = -flange_a.tau*ratio;
        annotation(
            Icon(graphics = {Ellipse(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Text(extent = {{-60, 20}, {60, -20}}, textString = "Gear V")}),
            Diagram(graphics));
    end VariableRatioGear;
end Gears;