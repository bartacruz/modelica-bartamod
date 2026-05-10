within Bartamod;

package Utils
  extends Modelica.Icons.UtilitiesPackage;

  model Ratio
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Real base(unit="Watts") = 1;
  Modelica.Blocks.Sources.Constant const(k = base) annotation(
      Placement(transformation(origin = {-22, -22}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Division division annotation(
      Placement(transformation(origin = {24, 0}, extent = {{-10, -10}, {10, 10}})));
  equation
  connect(u, division.u1) annotation(
      Line(points = {{-120, 0}, {-4, 0}, {-4, 6}, {12, 6}}, color = {0, 0, 127}));
  connect(division.y, y) annotation(
      Line(points = {{36, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(const.y, division.u2) annotation(
      Line(points = {{-10, -22}, {-2, -22}, {-2, -6}, {12, -6}}, color = {0, 0, 127}));
  end Ratio;
end Utils;