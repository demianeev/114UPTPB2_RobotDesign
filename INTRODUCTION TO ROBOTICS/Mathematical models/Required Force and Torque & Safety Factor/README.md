## Required Force and Torque

This analysis determines the minimum actuator requirements for the Z-axis. The X and Y axes are dominated by friction and inertial effects and are treated similarly.

**Mass Parameters:**

$$
\begin{aligned}
\text{camera mass: } m_c &= 0.30 \text{ kg} \\
\text{motor mass: } m_m &= 0.35 \text{ kg (standard value)}
\end{aligned}
$$

$$
\begin{aligned}
m_{total} &= m_c + m_m \\
m_{total} &= 0.65 \text{ kg}
\end{aligned}
$$

**Force in the Z-axis:**

$$
\begin{aligned}
F_z &= m_{total} \cdot g \\
F_z &= 0.65 \cdot 9.81 = 6.38 \text{ N}
\end{aligned}
$$

**Relationship force-torque in a belt system:**

$$
T = F_z \cdot r \quad \text{where} \quad r = 8 \text{ mm} = 0.008 \text{ m}
$$

$$
\begin{aligned}
T &= 6.38 \cdot 0.008 \\
T &= 0.051 \text{ Nm (Theoretical minimum torque)}
\end{aligned}
$$
