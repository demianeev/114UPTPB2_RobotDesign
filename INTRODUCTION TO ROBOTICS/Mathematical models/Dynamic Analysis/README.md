## Dynamic Analysis and Actuator Considerations

### *Modeling Approach*
The robot operates at low speeds and carries a lightweight camera payload. Consequently, dynamic effects such as Coriolis and centrifugal forces are negligible. A simplified quasi-static model is adopted, allowing independent axis-by-axis analysis.

### *Decoupled Dynamics (axis-by-axis equations)*

**X and Y axes:**

$$
m_x \ddot{x} + B_x \dot{x} + F_{cx} \text{sgn}(\dot{x}) = F_x
$$

**Z axis:**

$$
m_z \ddot{z} + B_z \dot{z} + F_{cz} \text{sgn}(\dot{z}) + m_z g = F_z
$$

**Where:**
* $F_i$ is the linear actuation force on each axis
* $m_i$ is the effective moving mass on each axis (for Y, this usually includes the X-axis carriage)
* $B_i$ is viscous friction
* $F_{ci}$ is Coulomb friction
* $g$ is gravitational acceleration

### References

**[1]** OMRON Industrial Automation, *FQ2 Smart Camera Datasheet*, Cat. No. Q193-E1-01, 2021. [Online]. Available: https://automation.omron.com. (Used for camera mass $m_c$).

**[2]** Schneider Electric, *NEMA 17 Stepper Motor Specifications - M-1713-1.5*, 2023. (Used for motor mass $m_m$ and nominal torque).

**[3]** Gates Corporation, *PowerGrip GT2 Belt Drives - Design Manual*, Denver, CO, 2018. (Used for pulley radius $r$ and transmission efficiency).

**[4]** ISO 10243, *Tools for pressing - Mechanical properties of steel springs*, International Organization for Standardization, 2019. (Reference for Safety Factor selection).
