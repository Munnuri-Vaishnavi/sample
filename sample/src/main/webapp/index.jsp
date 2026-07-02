<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Automatic Build Detection — GitHub to Jenkins</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --bg: #F7F8FA;
    --panel: #FFFFFF;
    --border: #E3E6EA;
    --text: #1F2430;
    --muted: #6B7280;
    --primary: #2F6FED;
    --success: #1E9E5A;
    --font: 'Inter', Arial, sans-serif;
  }
  *{ box-sizing: border-box; }
  body{
    margin:0;
    background: var(--bg);
    color: var(--text);
    font-family: var(--font);
    line-height:1.6;
  }
  .page{
    max-width: 900px;
    margin: 0 auto;
    padding: 60px 24px 100px;
  }
  h1{
    font-size: 30px;
    font-weight: 700;
    margin: 0 0 12px;
  }
  p.lead{
    color: var(--muted);
    font-size: 15px;
    max-width: 600px;
    margin: 0 0 48px;
  }
  .flow{
    display:flex;
    align-items:center;
    justify-content:center;
    gap: 16px;
    margin-bottom: 56px;
    flex-wrap: wrap;
  }
  .flow-step{
    background: var(--panel);
    border: 1px solid var(--border);
    border-radius: 10px;
    padding: 20px 24px;
    text-align:center;
    min-width: 140px;
    box-shadow: 0 1px 2px rgba(0,0,0,0.03);
  }
  .flow-step .icon{ font-size: 24px; margin-bottom: 8px; }
  .flow-step .name{ font-weight: 600; font-size: 14px; }
  .flow-step .desc{ color: var(--muted); font-size: 12px; margin-top: 4px; }
  .flow-arrow{ color: var(--border); font-size: 20px; }

  .card{
    background: var(--panel);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 32px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.04);
  }
  .card h2{
    font-size: 18px;
    font-weight: 600;
    margin: 0 0 6px;
  }
  .card p.hint{
    color: var(--muted);
    font-size: 13px;
    margin: 0 0 24px;
  }

  .btn{
    background: var(--primary);
    color: #fff;
    border: none;
    padding: 12px 22px;
    border-radius: 8px;
    font-family: var(--font);
    font-weight: 600;
    font-size: 14px;
    cursor: pointer;
    transition: opacity 0.15s ease;
  }
  .btn:hover{ opacity: 0.9; }
  .btn:disabled{ opacity: 0.5; cursor: not-allowed; }

  .status-line{
    margin-top: 24px;
    font-size: 14px;
    color: var(--muted);
    display:flex;
    align-items:center;
    gap: 10px;
    min-height: 22px;
  }
  .status-dot{
    width: 9px; height: 9px; border-radius: 50%;
    background: var(--border);
    transition: background 0.3s ease;
  }
  .status-dot.active{ background: var(--primary); }
  .status-dot.done{ background: var(--success); }

  .stages{
    margin-top: 28px;
    display:grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 12px;
  }
  @media (max-width: 620px){ .stages{ grid-template-columns: repeat(2, 1fr); } }

  .stage{
    border: 1px solid var(--border);
    border-radius: 8px;
    padding: 14px;
    text-align:center;
    background: #FAFBFC;
    transition: all 0.3s ease;
  }
  .stage .stage-name{ font-size: 13px; font-weight: 600; }
  .stage .stage-mark{ margin-top: 6px; font-size: 15px; color: var(--muted); }
  .stage.active{ border-color: var(--primary); background: #EEF3FE; }
  .stage.active .stage-mark{ color: var(--primary); }
  .stage.complete{ border-color: var(--success); background: #EAF8F0; }
  .stage.complete .stage-mark{ color: var(--success); }

  .result{
    margin-top: 24px;
    padding: 14px 16px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 500;
    display:none;
  }
  .result.show{ display:block; }
  .result.success{ background: #EAF8F0; color: var(--success); border: 1px solid #BFE8CF; }

  footer{
    text-align:center;
    color: var(--muted);
    font-size: 12px;
    margin-top: 56px;
  }
</style>
</head>
<body>

<div class="page">
  <h1>Automatic Build Detection</h1>
  <p class="lead">This demo shows how Jenkins automatically detects when new code is pushed to GitHub, and starts the build process without any manual step.</p>

  <div class="flow">
    <div class="flow-step">
      <div class="icon">&#128187;</div>
      <div class="name">Push Code</div>
      <div class="desc">Developer commits changes</div>
    </div>
    <div class="flow-arrow">&#8594;</div>
    <div class="flow-step">
      <div class="icon">&#128225;</div>
      <div class="name">GitHub</div>
      <div class="desc">Repository is updated</div>
    </div>
    <div class="flow-arrow">&#8594;</div>
    <div class="flow-step">
      <div class="icon">&#9881;</div>
      <div class="name">Jenkins</div>
      <div class="desc">Change is detected automatically</div>
    </div>
  </div>

  <div class="card">
    <h2>Try it</h2>
    <p class="hint">Click the button below to simulate pushing a code change and see Jenkins pick it up automatically.</p>

    <button class="btn" id="pushBtn">Simulate Code Push</button>

    <div class="status-line" id="statusLine">
      <div class="status-dot" id="statusDot"></div>
      <span id="statusText">Waiting for a code push...</span>
    </div>

    <div class="stages" id="stages">
      <div class="stage" data-stage="detect">
        <div class="stage-name">Detect Change</div>
        <div class="stage-mark">&#9675;</div>
      </div>
      <div class="stage" data-stage="build">
        <div class="stage-name">Build</div>
        <div class="stage-mark">&#9675;</div>
      </div>
      <div class="stage" data-stage="test">
        <div class="stage-name">Test</div>
        <div class="stage-mark">&#9675;</div>
      </div>
      <div class="stage" data-stage="deploy">
        <div class="stage-name">Deploy</div>
        <div class="stage-mark">&#9675;</div>
      </div>
    </div>

    <div class="result success" id="result">
      Build completed successfully. The new code is now live.
    </div>
  </div>

  <footer>Simple demo — no real GitHub or Jenkins connection is used.</footer>
</div>

<script>
(function(){
  var pushBtn = document.getElementById('pushBtn');
  var statusDot = document.getElementById('statusDot');
  var statusText = document.getElementById('statusText');
  var result = document.getElementById('result');
  var busy = false;

  function sleep(ms){
    return new Promise(function(resolve){ setTimeout(resolve, ms); });
  }

  function setStage(name, state){
    var el = document.querySelector('.stage[data-stage="' + name + '"]');
    el.className = 'stage' + (state ? (' ' + state) : '');
    var mark = el.querySelector('.stage-mark');
    if(state === 'active'){ mark.innerHTML = '&#9679;'; }
    else if(state === 'complete'){ mark.innerHTML = '&#10003;'; }
    else { mark.innerHTML = '&#9675;'; }
  }

  function resetStages(){
    ['detect','build','test','deploy'].forEach(function(s){ setStage(s, ''); });
    result.className = 'result success';
  }

  pushBtn.addEventListener('click', function(){
    if(busy) return;
    busy = true;
    pushBtn.disabled = true;
    resetStages();

    statusDot.className = 'status-dot active';
    statusText.textContent = 'New code pushed to GitHub...';

    sleep(900).then(function(){
      statusText.textContent = 'Jenkins detected the change automatically.';
      setStage('detect', 'active');
      return sleep(1000);
    }).then(function(){
      setStage('detect', 'complete');
      setStage('build', 'active');
      statusText.textContent = 'Building the project...';
      return sleep(1100);
    }).then(function(){
      setStage('build', 'complete');
      setStage('test', 'active');
      statusText.textContent = 'Running tests...';
      return sleep(1100);
    }).then(function(){
      setStage('test', 'complete');
      setStage('deploy', 'active');
      statusText.textContent = 'Deploying the update...';
      return sleep(1000);
    }).then(function(){
      setStage('deploy', 'complete');
      statusDot.className = 'status-dot done';
      statusText.textContent = 'Done. Jenkins handled everything automatically.';
      result.className = 'result success show';
      busy = false;
      pushBtn.disabled = false;
    });
  });
})();
</script>

</body>
</html>
