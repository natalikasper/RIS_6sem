const Sequelize = require('sequelize');
const config = require('./config.json');
const db = require('./context')(Sequelize, config);
const server = require('./server')(db, config);
async function clientSim(id)
{
    db.model.create({id: id, data: (Date.now()+7200000), clNum: 2})
}

(async function() {
    await db.sequelize.sync();

    setInterval(async () =>
    {
        db.model.count().then((count)=>{
            if(count >= 10)
            {
                server.logger.debug('trancate db');
                db.model.destroy({where: {}, truncate: true})
            }
            else
            {
                server.logger.debug('create entity');
                clientSim(count + 1);
            }
        }   );

    }, 5500);

    server.listen(8003, () => console.log('Server is running'));
})();