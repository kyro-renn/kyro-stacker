-- config.lua
Config = {}

Config.Zones = {
    theshop = {
        vector2(-60.27, -1097.11),
        vector2(-55.12, -1083.06),
        vector2(-26.40, -1093.83),
        vector2(-34.16, -1108.57)
    },
    sandymoto = {
        vector2(1711.37, 3784.41),
        vector2(1697.47, 3774.99),
        vector2(1689.70, 3786.53),
        vector2(1705.35, 3793.28)
    },
    flywheels = {
        vector2(1748.03, 3308.39),
        vector2(1778.97, 3322.08),
        vector2(1764.68, 3346.67),
        vector2(1741.69, 3332.80)
    },
    autokingexotics = {
        vector2(547.10, -229.53),
        vector2(521.88, -280.16),
        vector2(543.29, -291.01),
        vector2(566.83, -239.28)

    },

    prestigesupercars = {
        vector2(-760.35, -238.66),
        vector2(-788.52, -249.30),
        vector2(-811.79, -208.92),
        vector2(-782.94, -198.57)

    },
    devonportmotors = {
        vector2(-235.73, 6235.77),
        vector2(-196.04, 6202.92),
        vector2(-227.37, 6170.48),
        vector2(-263.17, 6206.87)

    },


    heavystrucks = {
        vector2(171.88, -3037.17),
        vector2(156.50, -3037.18),
        vector2(157.79, -3083.54),
        vector2(171.86, -3084.31)

    },
    
    sanders = {
        vector2(306.06, -1148.54),
        vector2(305.57, -1162.06),
        vector2(268.84, -1148.48),
        vector2(268.82, -1165.19)

    },
    lsdealership = {
        vector2(-301.06, -1035.64),
        vector2(-354.46, -1015.35),
        vector2(-345.81, -997.06),
        vector2(-296.63, -1016.08)

    },
    exoticmotrocycles = {
        vector2(-869.68, -178.26),
        vector2(-855.44, -203.30),
        vector2(-874.09, -204.22),
        vector2(-883.26, -185.30),

    }
}


Config.Spawn = {
    theshop = vector4(-17.05, -1102.56, 26.68, 163.89),
    autokingexotics = vector4(542.88, -253.25, 49.98, 341.15) ,
    exoticmotrocycles = vector4(-863.63, -177.21, 37.90, 216.61),
    prestigesupercars = vector4(-761.54, -243.73, 37.25, 131.16),
    devonportmotors = vector4(-239.33, 6239.30, 31.49, 138.32),
    heavystrucks =   vector4(190.55, -3089.01, 5.77, 355.32),
    sanders =   vector4(326.95, -1163.16, 29.29, 25.13),
    lsdealership =   vector4(-286.62, -1021.45, 30.38, 321.49),
    flywheels =   vector4(1771.05, 3304.40, 41.18, 290.41),
    sandymoto =   vector4(1720.12, 3763.73, 34.17, 176.37)
}


Config.jobs = {
    theshop = 'cardealer',
    autokingexotics = 'ake', 
    exoticmotrocycles = 'auto', 
    prestigesupercars = 'prestige', 
    devonportmotors = 'pdm', 
    heavystrucks = 'autoparts',
   sanders = 'sanders',
   lsdealership = 'gadgets',
   flywheels = 'gotur',
   sandymoto = 'benefactor',
}