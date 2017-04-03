$("body")[0].className = "index-html";
var w = 720,
    h = 600;

var force = d3.layout.force()
  .charge(-60)
  .linkDistance(40)
  .size([w, h]);

var svg = d3.select(".content").append("svg")
  .attr("width", w)
  .attr("height", h);

svg
  .append("defs")
    .append("pattern")
    .attr("id", "hello")
    .attr("x", "53")
    .attr("y", "3")
    .attr("patternUnits", "userSpaceOnUse")
    .attr("height", "80")
    .attr("width", "80")
      .append("image")
      .attr("x", "0")
      .attr("y", "0")
      .attr("height", "80")
      .attr("width", "80")
      .attr("xlink:href", "/img/about.jpg");

var [graph, idIndices] = (data => {
  data = Object.entries(data).reduce((acc, [group, d]) => (
    acc.concat(d.map(e => _.extend({ r: 7, g: parseInt(group) }, e)))
  ), []);
  var idIndices = data.reduce((acc, d, i) => {
    acc[d.i+''] = i;
    return acc;
  }, {});

  // Just for dev Convenience
  var maxIdSeen = _.max(_.keys(idIndices).map(k => parseInt(k)));
  var idFreeStatuses = Array(maxIdSeen).fill(true);
  _.keys(idIndices).forEach(id => { idFreeStatuses[id] = false });
  var freeIds = [];
  idFreeStatuses.forEach((free, i) => free && freeIds.push(i));
  freeIds.push((maxIdSeen + 1) + '+')
  console.debug('Free IDs:', freeIds.join())

  return [{
    nodes: data.map(d => _.omit(d, 'i', 't')),
    links: data.reduce((acc, d) => acc.concat((d.t || []).map(t => ({
      source: idIndices[d.i+''],
      target: idIndices[t+''],
    }))), [])
  }, idIndices];
})({
  // Hello
  "0": [
    {"i":0,"n":"Hello!","r":40,"u":"/about","t":[1,16,39,92]},
  ],
  // Personal
  "1": [
    {"i":17,"n":"Places","t":[18,19,20,21,22,23,24,108,101]},
    {"i":18,"n":"Boston, MA"},
    {"i":19,"n":"Worcester, MA"},
    {"i":20,"n":"Walla Walla, WA"},
    {"i":21,"n":"Charlottesville, VA"},
    {"i":22,"n":"Hanover, NH"},
    {"i":23,"n":"Birmingham, UK"},
    {"i":24,"n":"Bangkok, Thailand"},
    {"i":25,"n":"Music","t":[26,27,28,40,62,139]},
    {"i":26,"n":"Piano"},
    {"i":27,"n":"Clarinet"},
    {"i":28,"n":"Tuba"},
    {"i":29,"n":"Networks","t":[30,31,33,36,37,69,132]},
    {"i":30,"n":"Facebook","u":"https://www.facebook.com/artnc"},
    {"i":31,"n":"Sporcle","u":"http://www.sporcle.com/user/artnc"},
    {"i":33,"n":"Duolingo","u":"http://www.duolingo.com/#/artnc","t":[34,35,136,137,138]},
    {"i":34,"n":"French"},
    {"i":35,"n":"Spanish"},
    {"i":36,"n":"GitHub","u":"https://github.com/artnc","t":[95]},
    {"i":37,"n":"Google+","u":"https://plus.google.com/117410706532450381491?rel=author"},
    {"i":39,"n":"Personal","r":17,"t":[17,25,29,159,167]},
    {"i":62,"n":"Concert Band"},
    {"i":63,"n":"Track &amp; Field","t":[70,71,72]},
    {"i":64,"n":"Knowledge Bowl","t":[97]},
    {"i":65,"n":"Math Contests","t":[73,74,75,76,77,78]},
    {"i":69,"n":"LinkedIn","u":"http://www.linkedin.com/in/artnc/"},
    {"i":70,"n":"100m"},
    {"i":71,"n":"200m"},
    {"i":72,"n":"4x100m Relay"},
    {"i":73,"n":"AMC"},
    {"i":74,"n":"AIME"},
    {"i":75,"n":"UKMT"},
    {"i":76,"n":"Math is Cool","t":[97]},
    {"i":77,"n":"MathCounts"},
    {"i":78,"n":"Math League"},
    {"i":96,"n":"Boy Scouts"},
    {"i":97,"n":"Washington State Champion"},
    {"i":100,"n":"AP Scholar with Distinction","t":[115]},
    {"i":101,"n":"Pittsburgh, PA"},
    {"i":108,"n":"Madison, WI"},
    {"i":136,"n":"Italian"},
    {"i":137,"n":"Portuguese"},
    {"i":138,"n":"Swedish"},
    {"i":139,"n":"Guitar"},
    {"i":132,"n":"SoundCloud","u":"https://soundcloud.com/artnc"},
    {"i":159,"n":"Other interests","t":[160,161,162,163,164,166]},
    {"i":160,"n":"Pokémon"},
    {"i":161,"n":"Trivia","t":[31]},
    {"i":162,"n":"Design","t":[165]},
    {"i":163,"n":"Language","t":[165]},
    {"i":164,"n":"Lifting things up &amp; putting them down again"},
    {"i":165,"n":"Typography"},
    {"i":166,"n":"Board games"},
    {"i":167,"n":"High School","t":[62,63,64,65,96,100]},
  ],
  // Coding
  "2": [
    {"i":2,"n":"Web","t":[3,4,5,10,11,13,83,86,87,98]},
    {"i":3,"n":"HTML"},
    {"i":4,"n":"JavaScript"},
    {"i":5,"n":"CSS"},
    {"i":6,"n":"Java"},
    {"i":7,"n":"Redis"},
    {"i":8,"n":"Python","t":[80,129]},
    {"i":9,"n":"LaTeX"},
    {"i":10,"n":"jQuery"},
    {"i":11,"n":"Backbone"},
    {"i":12,"n":"Android","t":[6]},
    {"i":13,"n":"PhoneGap"},
    {"i":14,"n":"AutoHotkey"},
    {"i":15,"n":"TI-BASIC"},
    {"i":16,"n":"Coding","r":17,"t":[45,109,127,146]},
    {"i":38,"n":"PHP","t":[158]},
    {"i":45,"n":"Frontend","t":[2,12,13,79]},
    {"i":60,"n":"MySQL"},
    {"i":61,"n":"C#"},
    {"i":66,"n":"Deployment","t":[67,81,128,131,145]},
    {"i":67,"n":"Apache"},
    {"i":79,"n":"Universal Windows","t":[61,147,157]},
    {"i":80,"n":"Pyramid"},
    {"i":81,"n":"Nginx"},
    {"i":83,"n":"AngularJS"},
    {"i":86,"n":"React"},
    {"i":87,"n":"TypeScript"},
    {"i":95,"n":"Git"},
    {"i":98,"n":"Sass / Less"},
    {"i":109,"n":"Backend","t":[8,38,66,142,143]},
    {"i":111,"n":"Arch Linux"},
    {"i":112,"n":"Windows"},
    {"i":127,"n":"Tools","t":[95,111,112,151,152,155,156]},
    {"i":128,"n":"Jekyll"},
    {"i":129,"n":"Flask"},
    {"i":130,"n":"PostgreSQL"},
    {"i":131,"n":"Heroku"},
    {"i":141,"n":"DynamoDB"},
    {"i":142,"n":"Database","t":[7,60,130,141]},
    {"i":143,"n":"Elixir","t":[144]},
    {"i":144,"n":"Phoenix"},
    {"i":145,"n":"AWS","t":[141]},
    {"i":146,"n":"Random languages","t":[9,14,15]},
    {"i":151,"n":"Eclipse"},
    {"i":152,"n":"Visual Studio"},
    {"i":155,"n":"Fedora Linux"},
    {"i":156,"n":"Sublime Text"},
    {"i":157,"n":"XAML"},
    {"i":158,"n":"Laravel"},
  ],
  // UVa
  "3": [
    {"i":1,"n":"University of Virginia '13","r":17,"t":[32,40,41,42,43,99,113,115,134]},
    {"i":32,"n":"Order of the Orange Stole"},
    {"i":40,"n":"Cavalier Marching Band","t":[28]},
    {"i":41,"n":"Computer Science Major","t":[46,47,48,49,50,51,54,58,59,94,105,106,125]},
    {"i":42,"n":"Mathematics Major","t":[47,52,53,54,55,56,57,102,103,104]},
    {"i":43,"n":"Echols Scholar","u":"http://college.artsandsciences.virginia.edu/echols"},
    {"i":46,"n":"Discrete Mathematics"},
    {"i":47,"n":"Algorithms"},
    {"i":48,"n":"Parallel Computing"},
    {"i":49,"n":"Defense Against the Dark Arts"},
    {"i":50,"n":"Artificial Intelligence"},
    {"i":51,"n":"Computer Graphics","u":"http://www.cs.virginia.edu/~gfx/Courses/2012/IntroGraphics/index.html"},
    {"i":52,"n":"Multivariate Calculus"},
    {"i":53,"n":"Ordinary Diff Eq"},
    {"i":54,"n":"Linear Algebra"},
    {"i":55,"n":"Abstract Algebra","u":"http://people.virginia.edu/~des5e/F12,3354/F12,3354,syllabus.html"},
    {"i":56,"n":"Probability"},
    {"i":57,"n":"Statistics"},
    {"i":58,"n":"Computer Architecture"},
    {"i":59,"n":"Theory of Computation","u":"http://www.cs.virginia.edu/~robins/cs3102/CS3102_Syllabus.pdf"},
    {"i":85,"n":"Financial Market Simulation"},
    {"i":94,"n":"Digital Logic Design"},
    {"i":99,"n":"Thai Student Organization"},
    {"i":102,"n":"Stochastic Processes"},
    {"i":103,"n":"Derivative Securities"},
    {"i":104,"n":"Real Analysis"},
    {"i":105,"n":"Software Development Methods"},
    {"i":106,"n":"Program &amp; Data Representation"},
    {"i":133,"n":"CIFEr Hedge Fund Competition","u":"http://www.ieee-cifer.org/competition.html"},
    {"i":134,"n":"Intermediate Honors"},
    {"i":140,"n":"AP English Language"},
    {"i":113,"n":"Financial Engineering Research Group","t":[85,133]},
    {"i":115,"n":"Advanced Placement","t":[116,117,118,119,120,121,122,123,124,140]},
    {"i":116,"n":"AP Calculus BC"},
    {"i":117,"n":"AP Microeconomics"},
    {"i":118,"n":"AP Macroeconomics"},
    {"i":119,"n":"AP Biology"},
    {"i":120,"n":"AP Statistics"},
    {"i":121,"n":"AP Chemistry"},
    {"i":122,"n":"AP Physics B"},
    {"i":123,"n":"AP Computer Science"},
    {"i":124,"n":"AP English Literature"},
    {"i":125,"n":"Symbolic Logic"},
  ],
  // Work
  "4": [
    {"i":44,"n":"Triviality"},
    {"i":68,"n":"Private Tutor","t":[52,53,55,56]},
    {"i":82,"n":"OpenAI"},
    {"i":84,"n":"Ticketmelon"},
    {"i":88,"n":"Neuron Visualization","u":"/neuron"},
    {"i":89,"n":"OpenCV Page Turner"},
    {"i":90,"n":"LaTeX Homework Template"},
    {"i":91,"n":"Personal Projects","t":[44,88,89,90,107,110,126,150]},
    {"i":92,"n":"Work","r":17,"t":[68,82,84,91,93,153]},
    {"i":93,"n":"Duolingo","t":[147,148,149,150]},
    {"i":107,"n":"Jeopardy! Simulator"},
    {"i":110,"n":"Calculator Blackjack &amp; Simon"},
    {"i":126,"n":"chaidarun.com","u":"/colophon"},
    {"i":147,"n":"Duolingo for Windows"},
    {"i":148,"n":"Duolingo for Web"},
    {"i":149,"n":"Duolingo English Test"},
    {"i":150,"n":"Duolingo Earth"},
    {"i":153,"n":"Epic Systems","t":[84]},
  ],
});

force
  .nodes(graph.nodes)
  .links(graph.links)
  .start();

var link = svg.selectAll(".link")
  .data(graph.links)
  .enter().append("line")
    .attr("class", "link")
    .style("stroke-width", 1);

var tmp;
var node = svg.selectAll(".node")
  .data(graph.nodes)
  .enter().append("a")
    .attr("xlink:href", function(d) { return d.u; })
    .append("circle")
      .attr("class", function(d) { return "g" + d.g; })
      .attr("r", function(d) { return d.r; })
      .attr("data-title", function(d) { return d.n; })
      .call(force.drag);

var indexIds = _.invert(idIndices);
node.append("title")
  .text(function(d, i) { return indexIds[i]; });

force.on("tick", function() {
  link
    .attr("x1", function(d) { return d.source.x; })
    .attr("y1", function(d) { return d.source.y; })
    .attr("x2", function(d) { return d.target.x; })
    .attr("y2", function(d) { return d.target.y; });

  node
    .attr("cx", function(d) { return d.x; })
    .attr("cy", function(d) { return d.y; });
});







var nodes = $("svg .node");

nodes.tipsy({
    trigger: 'manual',
    gravity: 's',
    fade: true,
    html: true,
    opacity: 0.95,
    title: function() {
      return this.getAttribute("data-title");
    }
  })
  .hover(function() {
    $(this).tipsy("show");
  }, function() {
    $(this).tipsy("hide");
  });

// var prevCarouseled = 0;
// var interval = setInterval(function() {
//   $(nodes[prevCarouseled])
//     .tipsy("hide");
//   $(nodes[prevCarouseled = Math.floor(100 * Math.random())])
//     .tipsy("show");
// }, 1500);

$("a[href*='http']:not([href^='/'])").attr("target", "_blank");
