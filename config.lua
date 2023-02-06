Config = {}


Config.kordinatlar = {
    aseton = {x = 1394.67, y = 3601.8, z = 38.94, h = 201.74}, -- Embouteillage d'acétone
    damitma = {x = 1389.78, y = 3603.44, z = 38.94, h = 292.18}, -- Distillation d'acétone
    fosfor = {x = 1393.59, y = 3606.95, z = 38.94, h = 267.09}, -- Mélange de phosphore
    aluminyum = {x = 1391.85, y = 3606.01, z = 38.94, h = 113.37}, -- Cuisson / Mélange d'aluminium
}




Config.questions = {  -- Regarder le nombre avant la question pour avoir la réponse -- ex 458 = reponse 7 --

    title = 'Quelle quantité de phosphore rouge est nécessaire pour le mélange ML?',
    steps = {

       [1] = {label = '9.76 GR', value = 1},    -- entre 100 et 150
       [2] = {label = '4.32 GR', value = 2},      -- entre 150 et 200
       [3] =  {label = '15.2 GR', value = 3},    -- entre 200 et 550
       [4] =  {label = '7.54 GR', value = 4},   -- entre 250 et 300
       [5] =  {label = '2.6 GR', value = 5},    -- entre 300 et 350
       [6] =  {label = '19.1 GR', value = 6},    -- entre 350 et 400
       [7] =  {label = '23.76 GR', value = 7},    -- entre 450 et 500
    },

    titletwo = 'La cohérence du matériau a commencé à se solidifier que ferez-vous?',
    stepstwo = {
       [1] = {label = 'Ajouter 3/1 d\'aluminium au mélange', value = 1},
       [2] = {label = 'Attendez qu\'il cuit un peu plus', value = 2},
       [3] = {label = 'Éteignez le poêle et laissez-le sécher', value = 3},
    },
    titlethree = 'Le matériau a commencé à virer légèrement au bleu, que vas-tu faire?',
    stepsthree = {
       [1] = {label = 'Attendez qu\'il cuit un peu plus', value = 1},
       [2] = {label = 'Éteignez le poêle et laissez-le sécher', value = 2},
       [3] = {label = 'Réduisez la chaleur à 100 degrés', value = 3},
    },
    titlefour = 'Le matériau est bleu et brillant que ferez-vous?',
    stepsfour = {
       [1] = {label = 'Attendez qu\'il cuit un peu plus', value = 1},
       [2] = {label = 'Laisser reposer le matériel', value = 2},
       [3] = {label = 'Éteignez le poêle et laissez-le sécher', value = 3},
    },
}


----------------------------------------------------------------------
               -- Discord : https://discord.gg/Nf6bpx2jMJ
                           -- Insert#1224
----------------------------------------------------------------------