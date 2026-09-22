import express from 'express';
import cors from 'cors';
const app=express(); app.use(cors()); app.use(express.json());
app.get('/health',(_,res)=>res.json({ok:true,service:'localgo-api',version:'1.0.0'}));
app.get('/api/v1/config',(_,res)=>res.json({appName:'LOCALGO',tagline:'Find Local. Book Local. Grow Local.'}));
app.listen(process.env.PORT||3000,()=>console.log('LOCALGO API running'));
