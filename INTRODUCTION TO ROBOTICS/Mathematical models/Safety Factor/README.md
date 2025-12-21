## Safety Factor

An appropriate safety factor is applied to account for uncertainties such as friction variation and manufacturing tolerances.

Typically for light industrial robotics, we use a Safety Factor ($SF$) of 2.

$$
T_{design} = 2 \cdot 0.051 = 0.10 \text{ Nm}
$$

**Comparison with Motor Capacity:**

$$
T_{motor} \gg T_{design}
$$

The nominal torque of the selected motor is between **0.4 Nm** and **0.5 Nm**.

> **Conclusion:** The resulting torque requirement is well below the nominal torque of a standard NEMA 17 stepper motor, confirming its suitability for the proposed AOI application.
