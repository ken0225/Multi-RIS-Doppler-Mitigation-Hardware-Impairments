
### Disclaimer

The simulation code is licensed under the GPLv2 license and is delivered as it is. The authors encourage you to reuse the code in your research, but we cannot give any support. The readme file contains the instructions on how to run the code. As soon as you edit the code, you are on your own. My GitHub page is the only way that we are sharing simulation code, so there is no need to send us emails and ask for code related to other papers. The code is either openly available for everyone or it is not available at all.

# Multi-RIS-Doppler-Mitigation-Hardware-Impairments

This is a code package is related to the follow scientific article:

## Wang, Ke, Chan-Tong Lam, and Benjamin K. Ng, "[Positioning Information Based High-Speed Communications with Multiple RISs: Doppler Mitigation and Hardware Impairments](https://www.mdpi.com/2076-3417/12/14/7076/htm)," in _Applied Sciences_, 12, no.14: 7076, 2022.

### Abstract

In this paper, we consider a multiple reconfigurable intelligent surface (RIS)-assisted system using positioning information (PI) to explore the potential of Doppler effect mitigation and spectral efficiency (SE) enhancement in high-speed communications (HSC) in the presence of hardware impairments (HWI). In particular, we first present a general multi-RIS-assisted system model for HSC with HWI. Then, based on PI, different phase shift optimization strategies are designed and compared for maximizing SE, eliminating Doppler spread, and maintaining a very low delay spread. Moreover, we compare the performance of different numbers of RISs with HWI in terms of SE and delay spread. Finally, we extend our channel model from line-of-sight to the Rician channel to demonstrate the effectiveness and robustness of our proposed scheme. Numerical results reveal that the HWI of RISs increases the delay spread, but has no impact on Doppler shift and spread. Additionally, the multiple RIS system not only suffers a more severe delay spread, but is limited in SE due to the HWI. When the number of RISs increases from 2 to 16, the range of average spectral efficiency and delay spread are from 4 to 4.6 Bit/s/Hz and from 0.7 μs to 2.5 μs, respectively. In contrast to conventional RIS-assisted systems that require channel estimation, the proposed PI-based RIS system offers simplicity without compromising effectiveness and robustness in both SE enhancement and Doppler mitigation.

### How to use this code?

Please run "main_different_phase_shift_set_SE.m" to obtain the Figure 3 of the paper. By modifying the parameters, other figures can be get easily.

### This code package is licensed under the GPLv2 license. If you in any way use this code for research that results in publications, please cite the original article listed above.
