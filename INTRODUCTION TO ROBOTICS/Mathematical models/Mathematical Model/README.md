# 3-DOF Cartesian Robot: Mathematical Modeling and Documentation

This repository contains the complete mathematical model and kinematic analysis of a 3-Degree-of-Freedom (3-DOF) Cartesian robot. The system is composed exclusively of prismatic joints, allowing for a decoupled analysis of its motion in the task space.

## 1. Kinematic Analysis

Given the Cartesian nature of the robot, the kinematic description is straightforward. The Denavit-Hartenberg parameters are included in the full documentation for completeness, but the direct task-space formulation is preferred for control purposes.

### Direct Kinematic Model (DKM)
The position of the end-effector $\mathbf{P} = [x, y, z]^T$ is directly related to the joint displacements $\mathbf{q} = [q_1, q_2, q_3]^T$.

The homogeneous transformation matrix $T_{0}^{E}$ representing the end-effector pose is defined as:

$$
T_{0}^{E} = 
\begin{bmatrix}
1 & 0 & 0 & q_2 \\
0 & 1 & 0 & q_1 \\
0 & 0 & 1 & q_3 \\
0 & 0 & 0 & 1
\end{bmatrix}
$$

### Inverse Kinematic Model (IKM)
To reach a desired position $(x_d, y_d, z_d)$, the required joint displacements are:

$$
\begin{aligned}
q_1 &= y_d \\
q_2 &= x_d \\
q_3 &= z_d
\end{aligned}
$$

### Jacobian Matrix
Since each joint produces pure linear motion along one of the principal axes, the Jacobian matrix $J$ corresponds to the identity matrix:

$$
J = \frac{\partial \mathbf{x}}{\partial \mathbf{q}} = I_3
$$

---

## 2. Dynamic Model

A simplified quasi-static model is adopted, as Coriolis and centrifugal forces are negligible due to low operating speeds. The dynamics are decoupled, allowing for an axis-by-axis analysis.

### Decoupled Equations of Motion

**X and Y Axes (Horizontal Plane):**

$$
m_x \ddot{x} + B_x \dot{x} + F_{cx} \text{sgn}(\dot{x}) = F_x
$$

**Z Axis (Vertical Plane):**
Includes the effect of gravitational acceleration $g$.

$$
m_z \ddot{z} + B_z \dot{z} + F_{cz} \text{sgn}(\dot{z}) + m_z g = F_z
$$

**Definitions:**
* $F_i$: Linear actuation force.
* $m_i$: Effective moving mass (includes carriage mass for coupled axes).
* $B_i$: Viscous friction coefficient.
* $F_{ci}$: Coulomb friction force.
* $g$: Gravitational acceleration.

---

## 3. Torque & Force Transmission

The relationship between the motor torque ($\tau$) and the resulting linear force ($F$) depends on the transmission mechanism used for each axis.

### Belt Drive (X and Y Axes)
Relates force to torque via pulley radius ($r$) and transmission ratio ($N$).

$$
F = \frac{\tau_{motor} N}{r} \quad \Rightarrow \quad \tau = \frac{F r}{N}
$$

### Ball Screw (Z Axis)
Relates force to torque via screw lead ($L$) and mechanical efficiency ($\eta$).

$$
\tau = \frac{F L}{2 \pi \eta} \quad \Rightarrow \quad F = \frac{2 \pi \eta \tau}{L}
$$

**Parameters:**
* $r$: Pulley radius (m).
* $L$: Screw lead (m/rev).
* $\eta$: Mechanical efficiency ($0 \leq \eta \leq 1$).
* $N$: Gear/Belt transmission ratio.
