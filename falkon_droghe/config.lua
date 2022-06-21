Config = {}

Config.BlockRaccoltaFrom = "01:00" 
Config.BlockRaccoltaTo = "10:00" 
Config.BlockProcessamentoFrom = "01:00" 
Config.BlockProcessamentoTo	= "10:00"

Config.Droga = {
    ['Marijuana'] = {
        ['Raccolta'] = {
            ['pos'] = vector3(282.10797119141,6800.3046875,15.695816993713),
            ['item'] = 'marijuana',
            ['polizia'] = 0,
            ['libera'] = true,
        },
        ['Processo'] = {
            ['pos'] = vector3(-34.417507171631,1951.8754882812,190.35507202148),
            ['item'] = 'marijuana',
            ['item2'] = 'marijuanaprocessata',
            ['polizia'] = 0,
            ['libera'] = false,
        },
        ['Vendita'] = {
            ['pos'] = vector3(-22.572551727295,1953.779296875,190.0450592041),
            ['prezzo'] = 100,
            ['item'] = 'marijuanaprocessata',
            ['polizia'] = 0,
        },
    },
}