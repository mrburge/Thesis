

use cleanedData.dta 

summ hotelsdemandvolatility rmcdemandvolatility

* gen loghoteldemandvol = log( )

regress hotelsn hotelsdemandvolatility hotelsavgdemand population personalincome emp5yearchange unemployment employment

regress hotelshhi hotelsdemandvolatility hotelsavgdemand population personalincome emp5yearchange unemployment employment

regress rmcn rmcdemandvolatility rmcavgdemand population personalincome emp5yearchange unemployment employment

regress rmchhi rmcdemandvolatility rmcavgdemand population personalincome emp5yearchange unemployment employment

gen loghotelsn = log(hotelsn)

gen loghotelshhi = log(hotelshhi)

gen logrmcn = log(rmcn)

gen logrmchhi = log(rmchhi)

gen loghoteldv = log(hotelsdemandvolatility)

gen logrmcdv = log(rmcdemandvolatility)

*log lin

regress loghotelsn hotelsdemandvolatility hotelsavgdemand population personalincome emp5yearchange unemployment employment

regress loghotelshhi hotelsdemandvolatility hotelsavgdemand population personalincome emp5yearchange unemployment employment

regress logrmcn rmcdemandvolatility rmcavgdemand population personalincome emp5yearchange unemployment employment

regress logrmchhi rmcdemandvolatility rmcavgdemand population personalincome emp5yearchange unemployment employment

*lin log

regress hotelsn loghoteldv hotelsavgdemand population personalincome emp5yearchange unemployment employment

regress hotelshhi loghoteldv hotelsavgdemand population personalincome emp5yearchange unemployment employment

regress rmcn logrmcdv rmcavgdemand population personalincome emp5yearchange unemployment employment

regress rmchhi logrmcdv rmcavgdemand population personalincome emp5yearchange unemployment employment

*log log

regress loghotelsn loghoteldv hotelsavgdemand population personalincome emp5yearchange unemployment employment

regress loghotelshhi loghoteldv hotelsavgdemand population personalincome emp5yearchange unemployment employment

regress logrmcn logrmcdv rmcavgdemand population personalincome emp5yearchange unemployment employment

regress logrmchhi logrmcdv rmcavgdemand population personalincome emp5yearchange unemployment employment

