<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DevOps Pipeline Explorer — GitHub · Jenkins · Maven · Tomcat</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@500;600;700&family=IBM+Plex+Mono:wght@400;500;600&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
  :root{
    --bg: #0B1120;
    --panel: #121B2E;
    --panel-2: #16233A;
    --border: #223049;
    --text: #DCE3F0;
    --muted: #8492A8;
    --teal: #2DD4BF;
    --teal-dim: rgba(45,212,191,0.12);
    --amber: #F5A623;
    --red: #F0625A;
    --display: 'Sora', sans-serif;
    --body: 'Inter', sans-serif;
    --mono: 'IBM Plex Mono', monospace;
  }
  *{ box-sizing: border-box; }
  body{
    margin:0;
    background:
      radial-gradient(circle at 15% 0%, rgba(45,212,191,0.06), transparent 40%),
      radial-gradient(circle at 85% 100%, rgba(45,212,191,0.04), transparent 40%),
      var(--bg);
    color: var(--text);
    font-family: var(--body);
  }
  h1,h2,h3{ font-family: var(--display); margin:0; }
  ::-webkit-scrollbar{ width:8px; height:8px; }
  ::-webkit-scrollbar-thumb{ background: var(--border); border-radius:4px; }

  /* ---------- app shell ---------- */
  .app{
    display:flex;
    min-height: 100vh;
  }

  /* ---------- sidebar ---------- */
  .sidebar{
    width: 240px;
    flex-shrink:0;
    background: var(--panel);
    border-right: 1px solid var(--border);
    padding: 28px 16px;
    display:flex;
    flex-direction:column;
    gap: 4px;
  }
  .brand{
    display:flex; align-items:center; gap:10px;
    padding: 0 8px 24px;
    margin-bottom: 12px;
    border-bottom: 1px solid var(--border);
  }
  .brand .mark{
    width:30px; height:30px; border-radius:8px;
    background: var(--teal-dim);
    color: var(--teal);
    display:flex; align-items:center; justify-content:center;
    font-family: var(--display); font-weight:700; font-size:14px;
  }
  .brand .name{ font-family: var(--display); font-weight:600; font-size:14px; }
  .brand .name small{ display:block; color: var(--muted); font-weight:400; font-size:10px; margin-top:1px; }

  .nav-item{
    display:flex; align-items:center; gap:12px;
    padding: 11px 12px;
    border-radius: 8px;
    color: var(--muted);
    cursor:pointer;
    font-size: 13.5px;
    font-weight: 500;
    transition: all .15s ease;
    border: 1px solid transparent;
  }
  .nav-item:hover{ background: var(--panel-2); color: var(--text); }
  .nav-item.active{
    background: var(--teal-dim);
    color: var(--teal);
    border-color: rgba(45,212,191,0.25);
  }
  .nav-item .n-icon{ width:18px; height:18px; flex-shrink:0; }
  .nav-item .n-step{ font-family: var(--mono); font-size:10px; color: var(--muted); margin-right:2px; }

  .sidebar-foot{
    margin-top:auto;
    padding: 14px 12px 0;
    border-top: 1px solid var(--border);
    font-size: 11px;
    color: var(--muted);
    line-height:1.6;
  }

  /* ---------- main ---------- */
  .main{
    flex:1;
    padding: 44px 56px 80px;
    max-width: 1100px;
  }
  @media (max-width: 900px){
    .sidebar{ width:76px; padding: 20px 10px; }
    .brand .name, .nav-item span.label, .sidebar-foot{ display:none; }
    .nav-item{ justify-content:center; }
    .main{ padding: 32px 24px 60px; }
  }

  .panel{ display:none; animation: fadeIn .35s ease; }
  .panel.active{ display:block; }
  @keyframes fadeIn{ from{ opacity:0; transform: translateY(8px);} to{opacity:1; transform:translateY(0);} }

  .page-eyebrow{
    font-family: var(--mono);
    font-size: 11px;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    color: var(--teal);
    margin-bottom: 10px;
  }
  .page-title{ font-size: 28px; font-weight:700; margin-bottom:10px; }
  .page-sub{ color: var(--muted); font-size: 14px; max-width: 620px; margin-bottom: 40px; }

  .card{
    background: var(--panel);
    border: 1px solid var(--border);
    border-radius: 14px;
    padding: 28px;
  }
  .card + .card{ margin-top: 20px; }

  .btn{
    background: var(--teal);
    color: #08130F;
    border:none;
    padding: 12px 20px;
    border-radius: 8px;
    font-family: var(--display);
    font-weight:600;
    font-size: 13.5px;
    cursor:pointer;
    transition: all .15s ease;
  }
  .btn:hover{ transform: translateY(-1px); box-shadow: 0 6px 18px rgba(45,212,191,0.25); }
  .btn:disabled{ opacity:.5; cursor:not-allowed; transform:none; box-shadow:none; }
  .btn.ghost{
    background: transparent;
    color: var(--teal);
    border: 1px solid rgba(45,212,191,0.4);
  }

  /* ============ PAGE 1: Architecture ============ */
  .arch-diagram{
    display:flex; align-items:center; justify-content:space-between;
    gap: 0; margin-bottom: 8px; flex-wrap: wrap;
  }
  .arch-node{
    flex:1; min-width: 130px;
    background: var(--panel-2);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 20px 14px;
    text-align:center;
    cursor:pointer;
    transition: all .2s ease;
    position:relative;
  }
  .arch-node:hover, .arch-node.selected{
    border-color: var(--teal);
    background: var(--teal-dim);
  }
  .arch-node svg{ width:28px; height:28px; margin-bottom:8px; color: var(--teal); }
  .arch-node .a-name{ font-family: var(--display); font-weight:600; font-size:13.5px; }
  .arch-connector{ width:36px; height:2px; background: var(--border); position:relative; }
  .arch-connector::after{
    content:''; position:absolute; right:-4px; top:-3px;
    width:0; height:0; border: 4px solid transparent; border-left-color: var(--border);
  }

  .arch-detail{
    margin-top: 22px;
    padding-top: 22px;
    border-top: 1px dashed var(--border);
    display:none;
  }
  .arch-detail.show{ display:block; animation: fadeIn .3s ease; }
  .arch-detail h3{ font-size: 15px; color: var(--teal); margin-bottom: 8px; }
  .arch-detail p{ color: var(--muted); font-size: 13.5px; line-height:1.7; margin: 0 0 12px; }
  .arch-tags{ display:flex; gap:8px; flex-wrap:wrap; }
  .tag{
    font-family: var(--mono); font-size:11px; color: var(--teal);
    background: var(--teal-dim); border: 1px solid rgba(45,212,191,0.25);
    padding: 4px 10px; border-radius:999px;
  }

  /* ============ PAGE 2: CI Trigger ============ */
  .signal-row{
    display:flex; align-items:center; justify-content:center; gap: 6px;
    margin: 8px 0 28px;
  }
  .signal-node{
    display:flex; flex-direction:column; align-items:center; gap:8px; width: 110px;
  }
  .signal-node .circ{
    width:52px; height:52px; border-radius:50%;
    border: 2px solid var(--border);
    display:flex; align-items:center; justify-content:center;
    background: var(--panel-2);
    transition: all .3s ease;
  }
  .signal-node svg{ width:22px; height:22px; color: var(--muted); transition: color .3s ease; }
  .signal-node.on .circ{ border-color: var(--teal); box-shadow: 0 0 18px rgba(45,212,191,0.35); }
  .signal-node.on svg{ color: var(--teal); }
  .signal-node .s-label{ font-size:11px; color: var(--muted); font-family: var(--display); font-weight:600; }
  .signal-line{ flex:1; height:2px; background: var(--border); max-width:80px; position:relative; overflow:hidden; }
  .signal-line.live::after{
    content:''; position:absolute; top:0; left:-40%; width:40%; height:100%;
    background: var(--teal);
    animation: travel 0.8s linear infinite;
  }
  @keyframes travel{ to{ left:100%; } }

  .payload-box{
    margin-top: 20px;
    border: 1px solid var(--border);
    border-radius: 10px;
    overflow:hidden;
  }
  .payload-head{
    display:flex; align-items:center; justify-content:space-between;
    padding: 12px 16px;
    background: var(--panel-2);
    cursor:pointer;
    font-size: 13px;
    font-family: var(--mono);
    color: var(--muted);
  }
  .payload-head:hover{ color: var(--text); }
  .payload-body{
    max-height:0;
    overflow:hidden;
    transition: max-height .3s ease;
    background: #0A0F1C;
  }
  .payload-body.open{ max-height: 280px; overflow-y:auto; }
  .payload-body pre{
    margin:0; padding: 16px; font-family: var(--mono); font-size: 12px; color: #9FE6DA; line-height:1.7;
    white-space: pre-wrap;
  }
  .chev{ transition: transform .2s ease; }
  .chev.open{ transform: rotate(180deg); }

  .status-text{ text-align:center; color: var(--muted); font-size: 13.5px; margin-top:4px; min-height:20px; }

  /* ============ PAGE 3: Build pipeline ============ */
  .mvn-steps{
    display:flex; gap:6px; margin: 8px 0 24px; flex-wrap:wrap;
  }
  .mvn-step{
    flex:1; min-width: 90px;
    text-align:center;
    padding: 10px 6px;
    border-radius: 8px;
    background: var(--panel-2);
    border: 1px solid var(--border);
    font-family: var(--mono);
    font-size: 11.5px;
    color: var(--muted);
    transition: all .25s ease;
  }
  .mvn-step.active{ border-color: var(--amber); color: var(--amber); background: rgba(245,166,35,0.08); }
  .mvn-step.done{ border-color: var(--teal); color: var(--teal); background: var(--teal-dim); }

  .terminal{
    background: #060B14;
    border: 1px solid var(--border);
    border-radius: 10px;
    padding: 18px;
    height: 240px;
    overflow-y:auto;
    font-family: var(--mono);
    font-size: 12.5px;
  }
  .terminal .t-line{ color: var(--muted); margin-bottom:3px; }
  .terminal .t-line.ok{ color: var(--teal); }
  .terminal .t-line.head{ color: var(--text); font-weight:600; }
  .build-banner{
    margin-top:6px; border: 1px solid var(--teal); color: var(--teal);
    padding: 8px 12px; border-radius: 6px; display:inline-block;
    font-family: var(--mono); font-size:12.5px; background: var(--teal-dim);
  }

  /* ============ PAGE 4: Tomcat deploy ============ */
  .deploy-stage{
    display:flex; flex-direction:column; align-items:center;
    padding: 20px 0 8px;
  }
  .war-track{
    position:relative; width:100%; max-width:420px; height:120px;
    margin-bottom: 8px;
  }
  .war-box{
    position:absolute; top:0; left: 8px;
    width:56px; height:44px;
    background: var(--panel-2);
    border: 1px solid var(--border);
    border-radius:6px;
    display:flex; align-items:center; justify-content:center;
    font-family: var(--mono); font-size:10px; color: var(--muted);
    transition: all 1.1s cubic-bezier(.4,0,.2,1);
  }
  .war-box.dropped{
    top: 76px; left: calc(50% - 28px);
    border-color: var(--teal); color: var(--teal);
    opacity: 0;
  }
  .server-icon{
    position:absolute; bottom:0; left:50%; transform: translateX(-50%);
    width:80px; height:64px;
    border: 2px solid var(--border);
    border-radius: 8px;
    display:flex; flex-direction:column; align-items:center; justify-content:center;
    gap:4px;
    transition: border-color .4s ease;
  }
  .server-icon.active{ border-color: var(--teal); box-shadow: 0 0 20px rgba(45,212,191,0.25); }
  .server-icon svg{ width:26px; height:26px; color: var(--muted); transition: color .4s ease; }
  .server-icon.active svg{ color: var(--teal); }
  .server-icon .s-tag{ font-family: var(--mono); font-size:9px; color: var(--muted); }

  .manager-table{ width:100%; border-collapse: collapse; margin-top: 26px; font-size: 13px; }
  .manager-table th{
    text-align:left; color: var(--muted); font-family: var(--display); font-weight:600;
    font-size: 11px; text-transform:uppercase; letter-spacing:0.05em;
    padding: 9px 10px; border-bottom: 1px solid var(--border);
  }
  .manager-table td{ padding: 11px 10px; border-bottom: 1px solid var(--border); font-family: var(--mono); font-size:12.5px; }
  .status-pill{
    font-family: var(--display); font-size: 11px; font-weight:600;
    padding: 3px 10px; border-radius:999px;
    color: var(--muted); background: var(--panel-2); border: 1px solid var(--border);
  }
  .status-pill.running{ color: var(--teal); background: var(--teal-dim); border-color: rgba(45,212,191,0.3); }
  .app-url{ color: var(--teal); }
</style>
</head>
<body>

<div class="app">
  <div class="sidebar">
    <div class="brand">
      <div class="mark">DP</div>
      <div class="name">DevOps Pipeline<small>Explorer</small></div>
    </div>

    <div class="nav-item active" data-page="p1">
      <svg class="n-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5"/></svg>
      <span class="n-step">01</span><span class="label">Architecture</span>
    </div>
    <div class="nav-item" data-page="p2">
      <svg class="n-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M13 2 3 14h7l-1 8 10-12h-7l1-8z"/></svg>
      <span class="n-step">02</span><span class="label">CI Trigger</span>
    </div>
    <div class="nav-item" data-page="p3">
      <svg class="n-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M12 2v4M12 18v4M4.9 4.9l2.8 2.8M16.3 16.3l2.8 2.8M2 12h4M18 12h4M4.9 19.1l2.8-2.8M16.3 7.7l2.8-2.8"/><circle cx="12" cy="12" r="4"/></svg>
      <span class="n-step">03</span><span class="label">Build Pipeline</span>
    </div>
    <div class="nav-item" data-page="p4">
      <svg class="n-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 8h8M8 12h8M8 16h5"/></svg>
      <span class="n-step">04</span><span class="label">Deployment</span>
    </div>

    <div class="sidebar-foot">Demo environment.<br>No live GitHub, Jenkins, or Tomcat connection.</div>
  </div>

  <div class="main">

    <!-- PAGE 1: ARCHITECTURE -->
    <div class="panel active" id="p1">
      <div class="page-eyebrow">Overview</div>
      <div class="page-title">Pipeline Architecture</div>
      <div class="page-sub">A typical Java web project moves through four tools before it's live. Click each one to see what it actually does.</div>

      <div class="card">
        <div class="arch-diagram" id="archDiagram">
          <div class="arch-node" data-tool="github">
            <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C6.48 2 2 6.58 2 12.25c0 4.53 2.87 8.37 6.84 9.73.5.1.68-.22.68-.49 0-.24-.01-.87-.01-1.71-2.78.62-3.37-1.36-3.37-1.36-.46-1.19-1.11-1.51-1.11-1.51-.91-.64.07-.63.07-.63 1 .07 1.53 1.05 1.53 1.05.89 1.56 2.34 1.11 2.91.85.09-.66.35-1.11.63-1.37-2.22-.26-4.56-1.14-4.56-5.06 0-1.12.39-2.03 1.03-2.75-.1-.26-.45-1.31.1-2.72 0 0 .84-.28 2.75 1.05a9.3 9.3 0 0 1 5 0c1.91-1.33 2.75-1.05 2.75-1.05.55 1.41.2 2.46.1 2.72.64.72 1.03 1.63 1.03 2.75 0 3.93-2.34 4.79-4.57 5.05.36.32.68.94.68 1.9 0 1.37-.01 2.47-.01 2.81 0 .27.18.6.69.49A10.03 10.03 0 0 0 22 12.25C22 6.58 17.52 2 12 2z"/></svg>
            <div class="a-name">GitHub</div>
          </div>
          <div class="arch-connector"></div>
          <div class="arch-node" data-tool="jenkins">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 3.6-6 8-6s8 2 8 6"/></svg>
            <div class="a-name">Jenkins</div>
          </div>
          <div class="arch-connector"></div>
          <div class="arch-node" data-tool="maven">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><path d="M12 2 3 7v10l9 5 9-5V7l-9-5z"/><path d="M12 2v20M3 7l9 5 9-5"/></svg>
            <div class="a-name">Maven</div>
          </div>
          <div class="arch-connector"></div>
          <div class="arch-node" data-tool="tomcat">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 8h8M8 12h8M8 16h5"/></svg>
            <div class="a-name">Tomcat</div>
          </div>
        </div>

        <div class="arch-detail" id="archDetail">
          <h3 id="archDetailTitle">Select a tool above</h3>
          <p id="archDetailText"></p>
          <div class="arch-tags" id="archDetailTags"></div>
        </div>
      </div>
    </div>

    <!-- PAGE 2: CI TRIGGER -->
    <div class="panel" id="p2">
      <div class="page-eyebrow">Step 02</div>
      <div class="page-title">CI Trigger</div>
      <div class="page-sub">When code is pushed, GitHub sends a webhook event to Jenkins, which starts a job automatically — no manual step needed.</div>

      <div class="card">
        <div class="signal-row">
          <div class="signal-node" id="sn-github">
            <div class="circ"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C6.48 2 2 6.58 2 12.25c0 4.53 2.87 8.37 6.84 9.73.5.1.68-.22.68-.49 0-.24-.01-.87-.01-1.71-2.78.62-3.37-1.36-3.37-1.36-.46-1.19-1.11-1.51-1.11-1.51-.91-.64.07-.63.07-.63 1 .07 1.53 1.05 1.53 1.05.89 1.56 2.34 1.11 2.91.85.09-.66.35-1.11.63-1.37-2.22-.26-4.56-1.14-4.56-5.06 0-1.12.39-2.03 1.03-2.75-.1-.26-.45-1.31.1-2.72 0 0 .84-.28 2.75 1.05a9.3 9.3 0 0 1 5 0c1.91-1.33 2.75-1.05 2.75-1.05.55 1.41.2 2.46.1 2.72.64.72 1.03 1.63 1.03 2.75 0 3.93-2.34 4.79-4.57 5.05.36.32.68.94.68 1.9 0 1.37-.01 2.47-.01 2.81 0 .27.18.6.69.49A10.03 10.03 0 0 0 22 12.25C22 6.58 17.52 2 12 2z"/></svg></div>
            <div class="s-label">GitHub</div>
          </div>
          <div class="signal-line" id="line1"></div>
          <div class="signal-node" id="sn-webhook">
            <div class="circ"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M13 2 3 14h7l-1 8 10-12h-7l1-8z"/></svg></div>
            <div class="s-label">Webhook</div>
          </div>
          <div class="signal-line" id="line2"></div>
          <div class="signal-node" id="sn-jenkins">
            <div class="circ"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 3.6-6 8-6s8 2 8 6"/></svg></div>
            <div class="s-label">Jenkins</div>
          </div>
        </div>

        <div style="text-align:center;">
          <button class="btn" id="pushBtn">Simulate Code Push</button>
        </div>
        <div class="status-text" id="ciStatus">Waiting for a code push...</div>

        <div class="payload-box">
          <div class="payload-head" id="payloadToggle">
            <span>Webhook Payload (JSON sent by GitHub)</span>
            <svg class="chev" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 9l6 6 6-6"/></svg>
          </div>
          <div class="payload-body" id="payloadBody">
            <pre id="payloadText">// Click "Simulate Code Push" to generate a sample payload</pre>
          </div>
        </div>
      </div>
    </div>

    <!-- PAGE 3: BUILD PIPELINE -->
    <div class="panel" id="p3">
      <div class="page-eyebrow">Step 03</div>
      <div class="page-title">Build Pipeline</div>
      <div class="page-sub">Jenkins hands the project to Maven, which runs through its standard build lifecycle before producing a deployable package.</div>

      <div class="card">
        <div class="mvn-steps" id="mvnSteps">
          <div class="mvn-step" data-step="validate">validate</div>
          <div class="mvn-step" data-step="compile">compile</div>
          <div class="mvn-step" data-step="test">test</div>
          <div class="mvn-step" data-step="package">package</div>
          <div class="mvn-step" data-step="verify">verify</div>
          <div class="mvn-step" data-step="install">install</div>
        </div>

        <div style="text-align:center; margin-bottom:20px;">
          <button class="btn" id="buildBtn">Run mvn clean install</button>
        </div>

        <div class="terminal" id="terminal">
          <div class="t-line">$ waiting to build...</div>
        </div>
      </div>
    </div>

    <!-- PAGE 4: DEPLOYMENT -->
    <div class="panel" id="p4">
      <div class="page-eyebrow">Step 04</div>
      <div class="page-title">Deployment</div>
      <div class="page-sub">The packaged WAR file is dropped into Tomcat's webapps folder, and Tomcat picks it up and starts serving it automatically.</div>

      <div class="card">
        <div class="deploy-stage">
          <div class="war-track">
            <div class="war-box" id="warBox">app.war</div>
            <div class="server-icon" id="serverIcon">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 8h8M8 12h8M8 16h5"/></svg>
              <div class="s-tag">Tomcat</div>
            </div>
          </div>
          <button class="btn" id="deployBtn">Deploy to Tomcat</button>
        </div>

        <table class="manager-table">
          <thead><tr><th>Application</th><th>Status</th><th>URL</th></tr></thead>
          <tbody id="managerBody">
            <tr>
              <td>/myapp</td>
              <td><span class="status-pill" id="appStatusPill">Stopped</span></td>
              <td><span class="app-url" id="appUrl">—</span></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</div>

<script>
(function(){
  /* ---------- navigation ---------- */
  var navItems = document.querySelectorAll('.nav-item');
  var panels = document.querySelectorAll('.panel');
  navItems.forEach(function(item){
    item.addEventListener('click', function(){
      navItems.forEach(function(n){ n.classList.remove('active'); });
      panels.forEach(function(p){ p.classList.remove('active'); });
      item.classList.add('active');
      document.getElementById(item.getAttribute('data-page')).classList.add('active');
    });
  });

  function sleep(ms){ return new Promise(function(r){ setTimeout(r, ms); }); }

  /* ---------- PAGE 1: architecture detail ---------- */
  var archInfo = {
    github: {
      title: 'GitHub — Source Control',
      text: 'Stores the project source code and tracks every change through commits. When new code is pushed to a branch, GitHub can notify other tools automatically using webhooks.',
      tags: ['version control', 'webhooks', 'pull requests']
    },
    jenkins: {
      title: 'Jenkins — Automation Server',
      text: 'Listens for events from GitHub and runs a defined pipeline in response. It coordinates the build, test, and deploy steps so nothing has to be triggered by hand.',
      tags: ['CI/CD', 'pipelines', 'automation']
    },
    maven: {
      title: 'Maven — Build Tool',
      text: 'Manages project dependencies and runs the build lifecycle: compiling code, running tests, and packaging everything into a deployable artifact such as a WAR file.',
      tags: ['dependency management', 'build lifecycle', 'packaging']
    },
    tomcat: {
      title: 'Tomcat — Application Server',
      text: 'Hosts the packaged web application and serves it to users. Once a WAR file is deployed here, the application becomes accessible over HTTP.',
      tags: ['servlet container', 'hosting', 'runtime']
    }
  };
  var archNodes = document.querySelectorAll('.arch-node');
  var archDetail = document.getElementById('archDetail');
  var archTitle = document.getElementById('archDetailTitle');
  var archText = document.getElementById('archDetailText');
  var archTags = document.getElementById('archDetailTags');

  archNodes.forEach(function(node){
    node.addEventListener('click', function(){
      archNodes.forEach(function(n){ n.classList.remove('selected'); });
      node.classList.add('selected');
      var info = archInfo[node.getAttribute('data-tool')];
      archTitle.textContent = info.title;
      archText.textContent = info.text;
      archTags.innerHTML = '';
      info.tags.forEach(function(t){
        var span = document.createElement('span');
        span.className = 'tag';
        span.textContent = t;
        archTags.appendChild(span);
      });
      archDetail.classList.add('show');
    });
  });

  /* ---------- PAGE 2: CI trigger ---------- */
  var pushBtn = document.getElementById('pushBtn');
  var ciStatus = document.getElementById('ciStatus');
  var snGithub = document.getElementById('sn-github');
  var snWebhook = document.getElementById('sn-webhook');
  var snJenkins = document.getElementById('sn-jenkins');
  var line1 = document.getElementById('line1');
  var line2 = document.getElementById('line2');
  var payloadToggle = document.getElementById('payloadToggle');
  var payloadBody = document.getElementById('payloadBody');
  var payloadText = document.getElementById('payloadText');
  var chev = payloadToggle.querySelector('.chev');
  var ciBusy = false;

  payloadToggle.addEventListener('click', function(){
    payloadBody.classList.toggle('open');
    chev.classList.toggle('open');
  });

  function buildPayload(){
    var hash = Array.from({length:7}, function(){ return "0123456789abcdef"[Math.floor(Math.random()*16)]; }).join('');
    var lines = [
      '{',
      '  "ref": "refs/heads/main",',
      '  "repository": "tss-automation-bot",',
      '  "pusher": { "name": "vaishnavi" },',
      '  "head_commit": {',
      '    "id": "' + hash + '",',
      '    "message": "Update pipeline configuration"',
      '  }',
      '}'
    ];
    return lines.join('\n');
  }

  pushBtn.addEventListener('click', function(){
    if(ciBusy) return;
    ciBusy = true;
    pushBtn.disabled = true;
    [snGithub, snWebhook, snJenkins].forEach(function(n){ n.classList.remove('on'); });
    line1.classList.remove('live');
    line2.classList.remove('live');
    payloadText.textContent = buildPayload();

    ciStatus.textContent = 'Code pushed to GitHub...';
    snGithub.classList.add('on');

    sleep(600).then(function(){
      line1.classList.add('live');
      ciStatus.textContent = 'Webhook sending event to Jenkins...';
      return sleep(800);
    }).then(function(){
      line1.classList.remove('live');
      snWebhook.classList.add('on');
      line2.classList.add('live');
      return sleep(800);
    }).then(function(){
      line2.classList.remove('live');
      snJenkins.classList.add('on');
      ciStatus.textContent = 'Jenkins job triggered automatically.';
      ciBusy = false;
      pushBtn.disabled = false;
    });
  });

  /* ---------- PAGE 3: build pipeline ---------- */
  var buildBtn = document.getElementById('buildBtn');
  var terminal = document.getElementById('terminal');
  var mvnStepEls = document.querySelectorAll('.mvn-step');
  var buildBusy = false;

  function logLine(text, cls){
    var div = document.createElement('div');
    div.className = 't-line' + (cls ? ' ' + cls : '');
    div.textContent = text;
    terminal.appendChild(div);
    terminal.scrollTop = terminal.scrollHeight;
  }

  buildBtn.addEventListener('click', function(){
    if(buildBusy) return;
    buildBusy = true;
    buildBtn.disabled = true;
    terminal.innerHTML = '';
    mvnStepEls.forEach(function(s){ s.className = 'mvn-step'; });

    var steps = [
      { key:'validate', log:'Validating project structure...' },
      { key:'compile',  log:'Compiling source files...' },
      { key:'test',     log:'Running unit tests... 24/24 passed' },
      { key:'package',  log:'Packaging application as WAR...' },
      { key:'verify',   log:'Verifying package integrity...' },
      { key:'install',  log:'Installing artifact to local repository...' }
    ];

    logLine('$ mvn clean install', 'head');

    var p = Promise.resolve();
    steps.forEach(function(step){
      p = p.then(function(){
        var el = document.querySelector('.mvn-step[data-step="' + step.key + '"]');
        el.className = 'mvn-step active';
        logLine('[' + step.key.toUpperCase() + '] ' + step.log);
        return sleep(650);
      }).then(function(){
        var el = document.querySelector('.mvn-step[data-step="' + step.key + '"]');
        el.className = 'mvn-step done';
      });
    });

    p.then(function(){
      logLine('BUILD SUCCESS', 'ok');
      var banner = document.createElement('div');
      banner.className = 'build-banner';
      banner.textContent = 'Total time: 4.238s — app-1.0.war generated';
      terminal.appendChild(banner);
      terminal.scrollTop = terminal.scrollHeight;
      buildBusy = false;
      buildBtn.disabled = false;
    });
  });

  /* ---------- PAGE 4: deployment ---------- */
  var deployBtn = document.getElementById('deployBtn');
  var warBox = document.getElementById('warBox');
  var serverIcon = document.getElementById('serverIcon');
  var appStatusPill = document.getElementById('appStatusPill');
  var appUrl = document.getElementById('appUrl');
  var deployBusy = false;

  deployBtn.addEventListener('click', function(){
    if(deployBusy) return;
    deployBusy = true;
    deployBtn.disabled = true;

    warBox.classList.remove('dropped');
    warBox.style.top = '0px';
    warBox.style.left = '8px';
    serverIcon.classList.remove('active');
    appStatusPill.textContent = 'Deploying';
    appStatusPill.className = 'status-pill';
    appUrl.textContent = '—';

    // force reflow so the transition re-triggers
    void warBox.offsetWidth;

    sleep(150).then(function(){
      warBox.classList.add('dropped');
      return sleep(1200);
    }).then(function(){
      serverIcon.classList.add('active');
      appStatusPill.textContent = 'Running';
      appStatusPill.className = 'status-pill running';
      appUrl.textContent = 'localhost:8080/myapp';
      deployBusy = false;
      deployBtn.disabled = false;
    });
  });
})();
</script>

</body>
</html>

