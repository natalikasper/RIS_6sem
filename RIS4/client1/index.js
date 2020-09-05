const Sequelize = require('sequelize');
const config = require('./config.json');
const db = require('./context')(Sequelize, config);
const server = require('./server')(db, config);


    async function clientSim(id)
    {
        db.model.create({id: id, data: Date.now()+7200000, clNum: 1})
    }

(async function() {
    await db.sequelize.sync();
    server.logger.debug('truncate db');
    await db.model.destroy({where: {}, truncate: true})
        db.model.count().then((count)=>{
            if(count < 10)
            {
                for(i=count;i<10;i++)
                {
                server.logger.debug('create entity');
                clientSim(i + 1);
                }
            }
        }   );

    server.listen(8001, () => console.log('Server is running'));
})();