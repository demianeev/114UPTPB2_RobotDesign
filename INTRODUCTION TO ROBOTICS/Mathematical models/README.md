### ▶︎ This repository contains the documentation and the complete mathematical model of a 3-Degree-of-Freedom (3-DOF) Cartesian robot.
La fuerza es $F = m \cdot a$ en el sistema.

The robot is composed exclusively of prismatic joints (linear motion), which greatly simplifies its kinematic description. Therefore, the Denavit-Hartenberg (DH) parameterization is not particularly significant in this case.

---

### 1. Kinematic Models

**Direct Kinematic Model (DKM)**

The model relates the position of the end-effector (X, Y, Z) to the joint displacements (q1, q2, q3).

**Input Variables:**

* **q1:** Vertical displacement (Z-axis moving along Y).
* **q2:** Horizontal displacement (Y-axis moving along X).
* **q3:** Depth displacement (X-axis moving along Z).

**Homogeneous Transformation Matrix:** A 4x4 transformation matrix is provided, which represents the end-effector's position.

**Inverse Kinematic Model (IKM)**

To reach a desired position (xd, yd, zd), the robot must generate joint displacements that are directly equal to the desired coordinates (q1 = yd, q2 = xd, q3 = zd).

**Jacobian Matrix**

Since the robot is Cartesian, each joint produces a pure linear motion directly along one of the end-effector axes. This results in the Jacobian matrix being equal to the 3x3 identity matrix.

---

### 2. Decoupled Dynamics

The dynamic model is presented through decoupled equations (axis-by-axis).

* **X and Y Axes:** The dynamic equation includes terms for the effective moving mass (m), viscous friction (B), and Coulomb friction (Fc).
* **Z Axis:** This equation includes the same terms as the X/Y axes, plus an additional term for gravitational acceleration (g).

**Definitions:** The equations use variables for the linear actuation force (Fi), the effective moving mass (mi), viscous friction (Bi), Coulomb friction (Fci), and gravitational acceleration (g).

---

### 3. Torque/Force Transmission Relations

The relations used to convert motor torque to linear force are detailed for each drive mechanism:

* **Belt Drive (X and Y Axes):** The force is related to the motor torque through the pulley radius (r) and the gear/belt transmission ratio (N).
* **Ball Screw (Z Axis):** The force is related to the motor torque through the screw lead (L) and the mechanical efficiency (eta).

---

## Force Acting on the Z-Axis

The force required to lift the system against gravity is calculated as:

Fz = m_total · g

Where:

* m_total = 0.65 kg
* g = 9.81 m/s²

Fz = 0.65 · 9.81 = 6.38 N

---

## Torque Requirement (Belt-Driven System)

For a belt-driven transmission, the relationship between force and torque is:

T = Fz · r

Where:

* r = 8 mm = 0.008 m

T = 6.38 · 0.008
T = 0.051 Nm

**Theoretical minimum torque:**
T_min = 0.051 Nm

---

## Safety Factor

To account for friction, manufacturing tolerances, and uncertainties, a safety factor is applied.

* Safety Factor (SF) = 2

T_design = T_min · SF
T_design = 0.051 · 2 = 0.10 Nm

---

## Motor Selection

* Required design torque: 0.10 Nm
* Typical NEMA 17 nominal torque: 0.4 – 0.5 Nm

The required torque is well below the nominal torque of a standard NEMA 17 stepper motor, confirming its suitability for the proposed AOI application.

---

## Conclusion

The Z-axis torque requirement includes a sufficient safety margin, ensuring reliable operation under normal working conditions.
