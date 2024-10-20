---
layout: post
ogimage: /img/uva-xls.png
title: Ten Years of Logging My Life
---

> Update 2021-12-27: See [Hacker News](https://news.ycombinator.com/item?id=29692087) for 100+ more comments on this post.

I've been continuously recording my daily activities by hand since I was 17, amounting to 85,000+ activities over the span of a decade.

## Why?!

Self-awareness. Am I getting enough sleep and exercise? Often I become engrossed in whatever I'm doing and forget about biological obligations like eating. My [job](/projects#duolingo) is cool, but have I been making enough time for other people and hobbies I care about? Balance requires constant attention.

[The data](#observations) is also just endlessly fascinating to sift through. These pixels may not mean much to anyone else, but they tell an intensely personal story of my life's ups and downs over the past four years:

<!-- <p style="left:50%;max-width:95vw;position:relative;transform:translateX(-50%);width:calc(100% + 300px)">
<img src="/img/chronofile-area.png" />
</p> -->

![](/img/chronofile-area.png)

## How I track myself

My log's first entry is from October 16, 2011, soon after I started college. The original incarnation of the log was a massive spreadsheet in which I recorded a short summary of each day's happenings alongside a more detailed breakdown of the total hours spent per activity. Some columns' entries were automatically highlighted to indicate whether I reached certain daily goals, e.g. 8 hours of sleep.

![](/img/uva-xls.png)

This setup worked fine for the next couple years of college, and with some minor tweaks it continued to carry me through my first four years of full-time work as well.

There was definitely room for improvement, though. I had to either enter activities immediately after they ended or simply try to remember them until I got back to the keyboard. By mentally rounding each activity's duration to the nearest 15 minutes, I was able to enter data quickly but at the expense of precision. If I were to play piano for two hours, it would appear as a 2 in the spreadsheet but without any start or end time info. Tracking each activity's geographical location was similarly infeasible.

The solution: developing my own Android app.

![](/img/chronofile-screens.png)

I named it Chronofile, which I later learned was also the name of a [similar undertaking](https://en.wikipedia.org/wiki/Dymaxion_Chronofile) by Buckminster Fuller. Its code[^1] is open source and [available on GitHub](https://github.com/artnc/chronofile/).

[^1]: Chronofile uses [RxJava](https://github.com/ReactiveX/RxJava) to reimplement [Redux](https://redux.js.org/) (itself inspired by the [Elm architecture](https://guide.elm-lang.org/architecture/)) with type safety in [9 lines of code](https://github.com/artnc/chronofile/blob/e1b3a8f9405a5fcad079f625f5eae37e8ffabc94/app/src/main/java/com/chaidarun/chronofile/Store.kt#L102-L113), some of the most satisfying that I've ever written!

> Update 2021-12-27: Hello [Hacker News](https://news.ycombinator.com/item?id=29692087)! As requested, here's a [release APK](https://github.com/artnc/chronofile/releases) that you can try installing for yourself on Android 8+. Please open a GitHub issue if you run into any problems with the app.

Internally the app saves each log entry as a [TSV](https://en.wikipedia.org/wiki/Tab-separated_values) row containing the activity's name, descriptive note (optional), latitude, longitude, and start time in seconds since 1970:

```tsv
Work	40.461583	-79.926864		1639506621
```

Tapping on an old entry creates a new one for the same activity. Geolocation data comes from GPS. Chronofile's streamlined interface has cut down the time that I spend tracking myself each day from around ten minutes to less than one minute.

## Observations

<canvas alt="(Chart of practice per musical instrument)" id="music-chart"></canvas>

Turns out I've been playing music for an average of 45 minutes a day over the past decade, which is honestly a little embarrassing given that I'm certainly better at it by now but still so far from where I'd like to be. Oh well, no need to be world-class at your hobbies I guess?

I did expect [guitalele](/guitalele) to top the list but was shocked to see that I've sunk 943 hours into this tiny guitar that I picked up for less than $100! Possibly my highest-ROI purchase ever.

<canvas alt="(Chart of days between haircuts)" id="haircut-chart"></canvas>

Yes I did the quarantine hair thing. Still kinda regret finally cutting it :S

The remaining charts cover only the past four years since it's too cumbersome to extract this data from the pre-Chronofile spreadsheet era.

<canvas alt="(Chart of transportation methods)" id="transportation-chart"></canvas>

Lockdown sticks out like a sore thumb in this one too. It's a small miracle that my legs still work&mdash;there were some months when I didn't take a single step outside! Most of my pandemic travel has been on long road trips.

<canvas alt="(Chart of daily media consumption)" id="media-chart"></canvas>

Hidden in the chart above are a handful of games, 24 books, 39 shows, 102 movies, and thousands of news articles. I had never really been much into TV, but to stay somewhat social during lockdown I joined a viewing party that ended up covering all the corona classics: _Tiger King_, _Love Is Blind_, _Avatar_, kdrama after kdrama after kdrama...

You can see that "News" went flat for several months in 2021, corresponding to when my [TTRSS](/ttrss-heroku) server abruptly stopped fetching most of my RSS feeds due to some certificate error. Even though reading the news had been such a constant part of my daily life ever since the olden days of Slashdot and Google Reader, it took me five months to even notice this problem!

I have mixed feelings about that. I do think it's important to know what's going on in the world, but how much time is worth spending? Hacker News (via [hnrss](https://hnrss.github.io/)) is an incredibly valuable resource and I can't imagine having become as good of an engineer without it, but it's also a bit of an echo chamber. In any case, it's a relief to have such clear proof that I'm not as addicted to the news as I once suspected.

Notably absent from the chart is social media, which I mostly gave up after high school.

<canvas alt="(Chart of daily personal productivity)" id="productivity-chart"></canvas>

In contrast to the previous chart of passive media consumption, this one maps out "personal productivity" loosely defined as activities that improve myself in some measurable way or make progress toward non-work (unprofessional?) goals.

Occasions when things weren't all going my way were responsible for a few of the "Music" upticks above. I've found that playing music is the best medicine: it uses up vast amounts of physical, emotional, and mental energy that I might otherwise be tempted to spend more counterproductively.

Obviously exercise is good too, but I've been less sure about the particular kind. At no point during my first (and probably last) half-marathon in May 2019 or the training for it did I ever experience anything remotely resembling runner's high, and the [pump](https://www.youtube.com/watch?v=-xZQ0YZ7ls4) has never quite done it for me like it does for Arnold. I still lift a bit but most of my exercise nowadays comes from rock climbing and volleyball. As the chart suggests, those have been much more enjoyable to sustain at an average pace above one hour a day.

<canvas alt="(Chart of sleep hours)" id="sleep-chart"></canvas>

Monday always feels like the busiest day of my week, which the chart confirms by giving Monday the smallest bubbles of any night. Overall I'm pretty happy with how boring my sleep schedule has become in recent years, a far cry from the chaos of high school.

<canvas alt="(Chart of work hours)" id="work-chart"></canvas>

Some might find this chart more concerning. Is nothing sacred, other than Sunday 7am?! A less alarming interpretation: I have enough freedom in my work life and personal life that I can attend to both whenever it's most convenient.

For a few months during lockdown, I settled into a pattern where I would handle the more interpersonal aspects of my job in the afternoon, take a long nap in the evening, and do "real work" (i.e. coding) after midnight while free from any distractions. That stands in contrast to most of 2014, when I would head to the gym at 1am, go to bed at 2:30am, wake up at 10:30am&mdash;usually right on the minute without an alarm&mdash;and sit down in my office chair at 11am.

Which of those two schedules is better? I've found that at least for me, [biphasic sleep](https://en.wikipedia.org/wiki/Biphasic_and_polyphasic_sleep) didn't actually have much of a noticeable effect on my mood or productivity. Just getting 7-8 hours of sleep a day matters much more than how those hours are distributed.

<canvas alt="(Chart of monthly activity correlation)" id="correlation-chart"></canvas>

What surprises me most here is the extremely weak correlation between work and sleep, which I suppose is a good thing? Sleep and travel are negatively correlated because I categorize sleep while traveling as travel.

Apart from sleep, work is negatively correlated with _everything_! That makes sense&mdash;I do barely any business travel, for example. Burnout is definitely something to keep in mind here.

<canvas alt="(Chart of number of log entries per day)" id="switching-chart"></canvas>

This chart may be the hardest of all to interpret. Chronofile's interface has barely ever changed, so that doesn't explain any variations here. Adding a new entry takes so little time anyway that I doubt it affects my behavior.

Does lower activity churn equate to better focus, longer attention span? Or should I instead aim for _more_ variety each day? This chart's shape over time doesn't match any personal metric that comes to mind: happiness, stress level, body weight, credit score...

A few major life events such as relocations and changes in my _\*ahem\*_ romantic situation do seem to show up in the chart, but they account for only a small fraction of its peaks and valleys. Is this chart mostly just noise? Maybe any underlying causes here will become more apparent as time goes on.

## Conclusions

The quantity of time spent on a given activity doesn't say much about the quality of that time, of course. And without a control condition, it's hard to say whether any results of this experiment are causal or simply correlational. That said, I think it's still worth noting some changes in my own thoughts and behavior that began around the time I started this project.

I get a dramatically more reasonable amount of sleep, a daily average of 7 hours and 38 minutes over the past decade.

I can make everyday plans with greater precision, knowing exactly how many minutes I'll need to shower or drive or buy groceries or do laundry or water the plants.

I spend much less time on single-player games and idle internet stuff like Reddit. I fairly often still give them my full attention, but for the most part they're restricted to downtime during other activities like traveling and eating. I don't mean to suggest that these are bad habits in any practical or moral sense, just that I now have better control over them as opposed to the other way around.

Speaking more generally&mdash;although it may sound like Chronofile has taken over my life, it's really no more stressful or controlling than my car's speedometer. They're both tools that do nothing more than show me the results of my _own_ decisions, and it's now equally hard to imagine flying blind without them.

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.min.js"></script>
<script>
document.fonts.ready.then(() => {
  // Set global defaults
  const mergeObjects = (src, dst) => Object.entries(src).forEach(([k, v]) => {
    if (v && typeof v === "object") {
      mergeObjects(v, dst[k]);
    } else {
      dst[k] = v;
    }
  });
  mergeObjects({
    animation: false,
    color: "#c8c8c8",
    font: { family: "Open Sans, sans-serif" },
    plugins: {
      legend: { display: false },
      title: { display: true },
    },
    responsive: false,
    scale: { grid: { display: false, drawBorder: false } },
  }, Chart.defaults);

  // Render individual charts
  const monthLabels = ["Jan '18", "Feb '18", "Mar '18", "Apr '18", "May '18", "Jun '18", "Jul '18", "Aug '18", "Sep '18", "Oct '18", "Nov '18", "Dec '18", "Jan '19", "Feb '19", "Mar '19", "Apr '19", "May '19", "Jun '19", "Jul '19", "Aug '19", "Sep '19", "Oct '19", "Nov '19", "Dec '19", "Jan '20", "Feb '20", "Mar '20", "Apr '20", "May '20", "Jun '20", "Jul '20", "Aug '20", "Sep '20", "Oct '20", "Nov '20", "Dec '20", "Jan '21", "Feb '21", "Mar '21", "Apr '21", "May '21", "Jun '21", "Jul '21", "Aug '21", "Sep '21", "Oct '21", "Nov '21", "Dec '21"];
  const haircutDays = [
    57,
    95,
    93,
    85,
    92,
    97,
    57,
    41,
    43,
    43,
    42,
    47,
    120,
    168,
    81, // until oct 15, 2015
    164, // until mar 28, 2016
    76,
    72, // split from 322
    86, // split from 322
    80, // split from 322
    84, // split from 322 until apr 30, 2017
    122, // split from 357
    102, // split from 357
    134, // split from 357 until apr 22, 2018
    77,
    76,
    43,
    35,
    35,
    34,
    42,
    35,
    50,
    48,
    28,
    35,
    41,
    44,
    27,
    28,
    256,
    30,
    34,
    36,
    42,
    42,
    41,
    72,
    23,
    42
  ];
  const bubbleOptions = {
    clip: 40,
    events: [],
    scales: {
      x: {
        min: 0,
        max: 23,
        ticks: {
          callback: value => value % 3 ? "" : value === 0 ? "12am" : value === 12 ? "12pm" : value < 12 ? `${value}am` : `${value - 12}pm`,
          padding: 15,
          stepSize: 3,
        }
      },
      y: {
        reverse: true,
        ticks: {
          callback: value => ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][value],
          padding: 15,
        },
      },
    },
  };
  const correlationData = [
    [1,0,0,0,0,0,0,0,0,0],
    [0.008176371527,1,0,0,0,0,0,0,0,0,0],
    [0.005383377635,-0.3963415937,1,0,0,0,0,0,0,0,0],
    [-0.1664989388,-0.0693359137,-0.07860970823,1,0,0,0,0,0,0,0],
    [0.04085778615,-0.3352397547,-0.04903616957,-0.1278800239,1,0,0,0,0,0,0],
    [0.2082741975,-0.001373978466,-0.4178344017,0.03162809882,0.1541555084,1,0,0,0,0,0],
    [0.1214638688,-0.1767920413,-0.3414280152,0.3720877076,0.1593224842,0.3143167272,1,0,0,0,0],
    [-0.4521179127,-0.3207140753,0.283728704,0.08403995982,0.1189739165,-0.2121134805,-0.3173369063,1,0,0,0],
    [0.2078986006,-0.183195081,-0.4046147748,-0.3052183756,0.1090788851,0.1998981457,0.06021061275,-0.3081830436,1,0,0],
    [-0.1700525107,-0.4120136877,0.4008586175,0.2766714432,0.05736317522,-0.009161975885,0.03032305445,0.3999532407,-0.3678647283,1,0],
    [-0.2609036101,-0.197422513,-0.319693051,-0.01406227662,0.05112123312,-0.2214213993,0.08507022619,-0.1340874535,0.1797060268,-0.2312480792,1],
  ];
  const correlationPositives = [];
  const correlationNegatives = [];
  for (let i = 0; i < correlationData.length; ++i) {
    for (let j = 0; j < correlationData.length; ++j) {
      const v = correlationData[i][j] ? correlationData[i][j] : correlationData[j][i];
      (v > 0 ? correlationPositives : correlationNegatives).push({x:i,y:j,r:24*Math.sqrt(Math.abs(v))});
    }
  }
  const correlationScale = {
    ticks: {
      callback: value => ["Sleep","Work","People","Food","Chores","Read","Music","Travel","Projects","Exercise","Other"][value],
      padding: 30,
    },
  };
  new Chart(
    document.getElementById("correlation-chart"),
    {
      data: {
        datasets: [
          {
            backgroundColor: "#59a14f",
            data: correlationPositives,
          },
          {
            backgroundColor: "#e15759",
            data: correlationNegatives,
          },
        ],
        labels: [...new Array(168)].map(_ => ""),
      },
      options: {
        ...bubbleOptions,
        aspectRatio: 1.04,
        plugins: { title: { padding: 30, text: "Monthly activity correlation, 2018-2021" } },
        scales: { x: correlationScale, y: {...correlationScale } },
      },
      type: "bubble",
    }
  );
  new Chart(
    document.getElementById("haircut-chart"),
    {
      data: {
        datasets: [{
          backgroundColor: "#4e79a7",
          data: haircutDays,
        }],
        labels: [...new Array(haircutDays.length)].map(_ => ""),
      },
      options: {
        plugins: { title: { text: "Days between haircuts, 2011-2021" } },
      },
      type: "bar",
    }
  );
  new Chart(
    document.getElementById("media-chart"),
    {
      data: {
        datasets: [
          {
            backgroundColor: "#4e79a7",
            data: [25, 17, 19, 17, 12, 22, 14, 13, 27, 22, 18, 14, 21, 22, 18, 15, 8, 13, 9, 6, 13, 27, 12, 9, 11, 5, 14, 8, 8, 8, 7, 23, 13, 29, 43, 22, 22, 9, 6, 23, 19, 22, 1, 4, 3, 0, 0, 14],
            label: "News",
          },
          {
            backgroundColor: "#f28e2c",
            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 23, 10, 10, 5, 6, 5, 7, 14, 6, 6, 14, 13, 20, 18, 15, 17, 30, 30, 19, 2, 12, 70, 83, 1, 5],
            label: "Video games",
          },
          {
            backgroundColor: "#e15759",
            data: [3, 0, 0, 14, 5, 22, 22, 5, 0, 14, 8, 12, 11, 2, 41, 9, 4, 13, 24, 21, 7, 11, 6, 18, 21, 0, 8, 8, 1, 6, 16, 9, 0, 0, 3, 1, 6, 4, 0, 4, 0, 0, 3, 0, 9, 13, 4, 5],
            label: "Movies",
          },
          {
            backgroundColor: "#76b7b2",
            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 28, 189, 154, 74, 91, 62, 54, 7, 34, 89, 0, 0, 0, 0, 0, 0, 2, 0, 0, 16, 0, 0],
            label: "TV",
          },
          {
            backgroundColor: "#59a14f",
            data: [0, 0, 0, 0, 0, 0, 0, 3, 14, 48, 28, 76, 3, 2, 0, 5, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 38, 18],
            label: "Books",
          },
        ],
        labels: monthLabels,
      },
      options: {
        plugins: {
          legend: { display: true, position: "bottom" },
          title: { text: "Average daily minutes of media consumption" },
        },
        scales: {
          x: { stacked: true },
          y: { stacked: true },
        },
      },
      type: "bar",
    }
  );
  new Chart(
    document.getElementById("music-chart"),
    {
      data: {
        datasets: [{
          backgroundColor: "#4e79a7",
          data: [
            // uva.xls, me.ods, Chronofile
            28 + 0 + 1,
            8,
            0 + 335 + 608,
            151 + 113 + 111,
            0 + 10 + 2,
            396 + 172 + 215,
            8 + 36 + 9,
            192 + 0 + 0,
            30 + 0 + 318,
          ],
        }],
        labels: [
          "Bass guitar",
          "Clarinet",
          "Guitalele",
          "Guitar",
          "Harmonica",
          "Piano",
          "Saxophone",
          "Sousaphone",
          "Tuba",
        ],
      },
      options: {
        indexAxis: "y",
        plugins: { title: { text: "Hours per musical instrument, 2011-2021" } },
      },
      type: "bar",
    }
  );
  new Chart(
    document.getElementById("productivity-chart"),
    {
      data: {
        datasets: [
          {
            backgroundColor: "#4e79a7",
            data: [51, 29, 4, 19, 9, 26, 24, 45, 54, 44, 26, 58, 65, 56, 62, 43, 76, 69, 87, 57, 133, 87, 117, 48, 71, 87, 76, 30, 42, 52, 50, 20, 42, 122, 68, 39, 73, 54, 44, 49, 27, 62, 12, 44, 44, 53, 20, 44],
            label: "Music",
          },
          {
            backgroundColor: "#f28e2c",
            data: [16, 7, 12, 8, 9, 7, 10, 35, 44, 50, 25, 39, 57, 58, 27, 29, 34, 20, 37, 46, 31, 35, 40, 29, 24, 25, 18, 15, 24, 15, 15, 23, 5, 5, 0, 4, 15, 1, 0, 8, 29, 21, 73, 71, 62, 87, 75, 50],
            label: "Exercise",
          },
          {
            backgroundColor: "#e15759",
            data: [0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 15, 0, 0, 9, 22, 1, 1, 24, 0, 0, 0, 0, 41, 201, 153, 94, 55, 65, 101, 35, 5, 5, 2, 2, 3],
            label: "Language study",
          },
          {
            backgroundColor: "#76b7b2",
            data: [93, 4, 2, 4, 2, 0, 5, 2, 2, 0, 0, 40, 5, 13, 0, 10, 21, 35, 4, 5, 5, 17, 4, 12, 4, 9, 8, 1, 3, 3, 54, 5, 41, 42, 166, 69, 6, 26, 29, 21, 10, 6, 12, 5, 3, 2, 37, 83],
            label: "Other projects, e.g. this blog",
          },
        ],
        labels: monthLabels,
      },
      options: {
        plugins: {
          legend: { display: true, position: "bottom" },
          title: { text: "Average daily minutes of personal productivity" },
        },
        scales: {
          x: { stacked: true },
          y: { stacked: true },
        },
      },
      type: "bar",
    }
  );
  new Chart(
    document.getElementById("switching-chart"),
    {
      data: {
        datasets: [
          {
            backgroundColor: "#4e79a7",
            data: [20.4, 19.6, 19.7, 18.2, 16.9, 17.5, 18.6, 22.5, 27.1, 26.9, 23.5, 25.0, 26.6, 24.7, 23.8, 22.6, 23.5, 25.9, 23.2, 27.1, 29.9, 28.3, 32.9, 27.4, 28.8, 25.8, 24.5, 24.5, 21.5, 19.5, 21.0, 20.2, 17.5, 22.5, 22.6, 25.3, 28.6, 21.3, 18.8, 25.4, 26.1, 26.5, 21.8, 19.7, 20.9, 24.5, 22.9, 16.3],
          },
        ],
        labels: monthLabels,
      },
      options: {
        plugins: {
          title: { text: "Average daily number of log entries" },
        },
      },
      type: "bar",
    }
  );
  new Chart(
    document.getElementById("sleep-chart"),
    {
      data: {
        datasets: [
          {
            backgroundColor: "#4e79a7",
            data: [{"x": 1, "y": 3, "r": 5.8}, {"x": 2, "y": 3, "r": 7.0}, {"x": 3, "y": 3, "r": 8.4}, {"x": 4, "y": 3, "r": 9.5}, {"x": 5, "y": 3, "r": 9.9}, {"x": 6, "y": 3, "r": 10.3}, {"x": 7, "y": 3, "r": 10.5}, {"x": 9, "y": 3, "r": 9.4}, {"x": 10, "y": 3, "r": 7.0}, {"x": 3, "y": 4, "r": 7.9}, {"x": 4, "y": 4, "r": 8.8}, {"x": 5, "y": 4, "r": 9.7}, {"x": 6, "y": 4, "r": 10.4}, {"x": 7, "y": 4, "r": 10.5}, {"x": 8, "y": 4, "r": 10.4}, {"x": 9, "y": 4, "r": 9.6}, {"x": 19, "y": 4, "r": 2.8}, {"x": 20, "y": 4, "r": 2.8}, {"x": 2, "y": 5, "r": 6.8}, {"x": 3, "y": 5, "r": 8.0}, {"x": 4, "y": 5, "r": 9.0}, {"x": 5, "y": 5, "r": 9.6}, {"x": 6, "y": 5, "r": 10.3}, {"x": 7, "y": 5, "r": 10.6}, {"x": 8, "y": 5, "r": 10.4}, {"x": 3, "y": 6, "r": 8.2}, {"x": 4, "y": 6, "r": 9.0}, {"x": 5, "y": 6, "r": 9.6}, {"x": 6, "y": 6, "r": 10.1}, {"x": 7, "y": 6, "r": 10.3}, {"x": 8, "y": 6, "r": 10.3}, {"x": 9, "y": 6, "r": 9.8}, {"x": 3, "y": 0, "r": 7.2}, {"x": 4, "y": 0, "r": 8.5}, {"x": 5, "y": 0, "r": 9.4}, {"x": 6, "y": 0, "r": 10.4}, {"x": 7, "y": 0, "r": 10.8}, {"x": 8, "y": 0, "r": 10.8}, {"x": 9, "y": 0, "r": 10.0}, {"x": 10, "y": 0, "r": 9.2}, {"x": 3, "y": 1, "r": 8.0}, {"x": 4, "y": 1, "r": 9.2}, {"x": 5, "y": 1, "r": 10.2}, {"x": 6, "y": 1, "r": 10.5}, {"x": 7, "y": 1, "r": 10.9}, {"x": 8, "y": 1, "r": 10.7}, {"x": 9, "y": 1, "r": 9.7}, {"x": 10, "y": 1, "r": 7.3}, {"x": 11, "y": 1, "r": 4.9}, {"x": 20, "y": 1, "r": 1.7}, {"x": 21, "y": 1, "r": 2.8}, {"x": 6, "y": 2, "r": 10.6}, {"x": 7, "y": 2, "r": 10.8}, {"x": 8, "y": 2, "r": 10.6}, {"x": 9, "y": 2, "r": 9.5}, {"x": 10, "y": 2, "r": 7.1}, {"x": 20, "y": 2, "r": 2.6}, {"x": 8, "y": 3, "r": 10.2}, {"x": 17, "y": 3, "r": 1.9}, {"x": 18, "y": 3, "r": 2.8}, {"x": 19, "y": 3, "r": 3.2}, {"x": 1, "y": 6, "r": 6.3}, {"x": 2, "y": 6, "r": 7.1}, {"x": 17, "y": 6, "r": 4.8}, {"x": 18, "y": 6, "r": 5.2}, {"x": 0, "y": 0, "r": 2.5}, {"x": 1, "y": 0, "r": 3.3}, {"x": 2, "y": 0, "r": 5.5}, {"x": 14, "y": 0, "r": 3.6}, {"x": 1, "y": 1, "r": 5.7}, {"x": 2, "y": 1, "r": 6.9}, {"x": 2, "y": 2, "r": 6.7}, {"x": 3, "y": 2, "r": 8.2}, {"x": 4, "y": 2, "r": 9.6}, {"x": 5, "y": 2, "r": 10.4}, {"x": 1, "y": 4, "r": 5.5}, {"x": 2, "y": 4, "r": 6.7}, {"x": 21, "y": 5, "r": 3.7}, {"x": 22, "y": 5, "r": 4.9}, {"x": 23, "y": 5, "r": 5.1}, {"x": 0, "y": 6, "r": 5.6}, {"x": 16, "y": 6, "r": 4.1}, {"x": 1, "y": 2, "r": 5.2}, {"x": 1, "y": 5, "r": 5.8}, {"x": 19, "y": 6, "r": 4.3}, {"x": 21, "y": 6, "r": 3.5}, {"x": 22, "y": 6, "r": 3.3}, {"x": 23, "y": 6, "r": 2.6}, {"x": 9, "y": 5, "r": 9.6}, {"x": 10, "y": 6, "r": 8.7}, {"x": 11, "y": 6, "r": 7.6}, {"x": 14, "y": 6, "r": 4.7}, {"x": 15, "y": 6, "r": 4.5}, {"x": 10, "y": 4, "r": 7.7}, {"x": 21, "y": 4, "r": 3.3}, {"x": 22, "y": 4, "r": 4.9}, {"x": 23, "y": 4, "r": 5.3}, {"x": 10, "y": 5, "r": 7.4}, {"x": 20, "y": 6, "r": 3.6}, {"x": 0, "y": 4, "r": 4.7}, {"x": 13, "y": 0, "r": 4.6}, {"x": 23, "y": 0, "r": 4.4}, {"x": 0, "y": 1, "r": 4.8}, {"x": 17, "y": 0, "r": 2.8}, {"x": 18, "y": 0, "r": 2.9}, {"x": 19, "y": 0, "r": 2.9}, {"x": 0, "y": 5, "r": 5.2}, {"x": 11, "y": 0, "r": 8.0}, {"x": 12, "y": 6, "r": 6.2}, {"x": 13, "y": 6, "r": 5.1}, {"x": 22, "y": 0, "r": 4.1}, {"x": 23, "y": 3, "r": 5.0}, {"x": 20, "y": 0, "r": 2.9}, {"x": 21, "y": 3, "r": 4.3}, {"x": 22, "y": 3, "r": 4.8}, {"x": 14, "y": 1, "r": 1.7}, {"x": 15, "y": 1, "r": 1.7}, {"x": 0, "y": 2, "r": 3.7}, {"x": 21, "y": 0, "r": 3.4}, {"x": 21, "y": 2, "r": 3.3}, {"x": 22, "y": 2, "r": 3.9}, {"x": 23, "y": 2, "r": 4.3}, {"x": 0, "y": 3, "r": 4.2}, {"x": 22, "y": 1, "r": 3.1}, {"x": 23, "y": 1, "r": 3.1}, {"x": 20, "y": 3, "r": 3.1}, {"x": 15, "y": 4, "r": 2.6}, {"x": 16, "y": 4, "r": 2.2}, {"x": 12, "y": 1, "r": 3.0}, {"x": 19, "y": 1, "r": 2.0}, {"x": 12, "y": 0, "r": 6.2}, {"x": 11, "y": 3, "r": 3.6}, {"x": 20, "y": 5, "r": 3.0}, {"x": 14, "y": 4, "r": 2.0}, {"x": 17, "y": 4, "r": 2.0}, {"x": 18, "y": 4, "r": 2.0}, {"x": 17, "y": 5, "r": 1.9}, {"x": 18, "y": 5, "r": 2.2}, {"x": 19, "y": 5, "r": 2.8}, {"x": 11, "y": 5, "r": 5.0}, {"x": 11, "y": 2, "r": 3.9}, {"x": 15, "y": 2, "r": 2.0}, {"x": 16, "y": 2, "r": 1.9}, {"x": 17, "y": 2, "r": 2.0}, {"x": 11, "y": 4, "r": 5.7}, {"x": 12, "y": 4, "r": 4.3}, {"x": 13, "y": 4, "r": 2.4}, {"x": 16, "y": 1, "r": 1.7}, {"x": 12, "y": 2, "r": 2.5}, {"x": 13, "y": 2, "r": 2.0}, {"x": 14, "y": 2, "r": 1.7}, {"x": 15, "y": 3, "r": 1.9}, {"x": 16, "y": 3, "r": 1.9}, {"x": 15, "y": 0, "r": 3.1}, {"x": 16, "y": 0, "r": 2.9}, {"x": 14, "y": 5, "r": 2.0}, {"x": 15, "y": 5, "r": 2.0}, {"x": 17, "y": 1, "r": 1.7}, {"x": 18, "y": 1, "r": 2.0}, {"x": 13, "y": 1, "r": 2.4}, {"x": 12, "y": 3, "r": 3.0}, {"x": 12, "y": 5, "r": 3.6}, {"x": 13, "y": 5, "r": 2.2}, {"x": 18, "y": 2, "r": 2.0}, {"x": 14, "y": 3, "r": 1.2}, {"x": 16, "y": 5, "r": 2.0}, {"x": 19, "y": 2, "r": 2.4}, {"x": 13, "y": 3, "r": 1.4}],
          },
        ],
        labels: [...new Array(168)].map(_ => ""),
      },
      options: {
        ...bubbleOptions,
        plugins: { title: { padding: 25, text: "Sleep, 2018-2021" } },
      },
      type: "bubble",
    }
  );
  new Chart(
    document.getElementById("transportation-chart"),
    {
      data: {
        datasets: [
          {
            backgroundColor: "#4e79a7",
            data: [0, 0, 0, 1, 2, 0, 0, 13, 20, 17, 17, 9, 13, 12, 16, 15, 23, 15, 21, 18, 26, 25, 27, 18, 15, 18, 11, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 12, 2, 44, 19, 18, 34, 19, 9],
            label: "Walk",
          },
          {
            backgroundColor: "#f28e2c",
            data: [36, 31, 44, 42, 45, 41, 37, 77, 22, 6, 61, 12, 15, 15, 7, 14, 18, 15, 28, 31, 31, 26, 53, 58, 27, 18, 29, 0, 0, 0, 2, 38, 20, 6, 1, 2, 1, 2, 0, 2, 69, 19, 133, 27, 52, 76, 84, 28],
            label: "Car",
          },
          {
            backgroundColor: "#e15759",
            data: [0, 34, 0, 32, 28, 0, 0, 8, 0, 0, 130, 9, 10, 42, 0, 13, 22, 0, 0, 0, 0, 0, 7, 92, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 0, 38, 16, 6, 5],
            label: "Airplane",
          },
          {
            backgroundColor: "#76b7b2",
            data: [0, 9, 0, 0, 0, 0, 0, 7, 0, 0, 16, 7, 5, 6, 0, 12, 1, 0, 0, 0, 0, 0, 8, 8, 7, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 6, 5],
            label: "Bus",
          },
          {
            backgroundColor: "#59a14f",
            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0],
            label: "Train",
          },
        ],
        labels: monthLabels,
      },
      options: {
        plugins: {
          legend: { display: true, position: "bottom" },
          title: { text: "Average daily minutes of travel" },
        },
        scales: {
          x: { stacked: true },
          y: { stacked: true },
        },
      },
      type: "bar",
    }
  );
  new Chart(
    document.getElementById("work-chart"),
    {
      data: {
        datasets: [
          {
            backgroundColor: "#4e79a7",
            data: [{"x": 18, "y": 3, "r": 10.4}, {"x": 21, "y": 4, "r": 5.9}, {"x": 9, "y": 5, "r": 2.9}, {"x": 10, "y": 5, "r": 5.7}, {"x": 11, "y": 5, "r": 8.4}, {"x": 11, "y": 4, "r": 7.8}, {"x": 12, "y": 4, "r": 9.3}, {"x": 14, "y": 4, "r": 10.5}, {"x": 15, "y": 4, "r": 10.6}, {"x": 16, "y": 4, "r": 10.4}, {"x": 17, "y": 4, "r": 10.6}, {"x": 18, "y": 4, "r": 10.2}, {"x": 19, "y": 4, "r": 8.4}, {"x": 12, "y": 5, "r": 9.5}, {"x": 14, "y": 5, "r": 10.3}, {"x": 15, "y": 5, "r": 10.4}, {"x": 16, "y": 5, "r": 10.4}, {"x": 17, "y": 5, "r": 10.4}, {"x": 18, "y": 5, "r": 9.8}, {"x": 19, "y": 5, "r": 7.6}, {"x": 21, "y": 5, "r": 4.9}, {"x": 23, "y": 5, "r": 4.3}, {"x": 13, "y": 6, "r": 3.8}, {"x": 20, "y": 0, "r": 2.8}, {"x": 21, "y": 0, "r": 3.5}, {"x": 11, "y": 1, "r": 8.8}, {"x": 12, "y": 1, "r": 10.1}, {"x": 14, "y": 1, "r": 10.7}, {"x": 15, "y": 1, "r": 10.7}, {"x": 16, "y": 1, "r": 10.6}, {"x": 17, "y": 1, "r": 10.6}, {"x": 18, "y": 1, "r": 10.4}, {"x": 19, "y": 1, "r": 9.4}, {"x": 21, "y": 1, "r": 5.7}, {"x": 22, "y": 1, "r": 5.8}, {"x": 23, "y": 1, "r": 7.3}, {"x": 0, "y": 2, "r": 6.9}, {"x": 1, "y": 2, "r": 6.2}, {"x": 11, "y": 2, "r": 9.0}, {"x": 12, "y": 2, "r": 10.1}, {"x": 14, "y": 2, "r": 11.0}, {"x": 15, "y": 2, "r": 10.8}, {"x": 16, "y": 2, "r": 10.6}, {"x": 17, "y": 2, "r": 10.6}, {"x": 19, "y": 2, "r": 8.1}, {"x": 20, "y": 2, "r": 5.8}, {"x": 23, "y": 2, "r": 6.3}, {"x": 0, "y": 3, "r": 6.7}, {"x": 1, "y": 3, "r": 5.5}, {"x": 2, "y": 3, "r": 5.2}, {"x": 3, "y": 3, "r": 4.7}, {"x": 4, "y": 3, "r": 4.1}, {"x": 9, "y": 3, "r": 3.7}, {"x": 10, "y": 3, "r": 6.8}, {"x": 11, "y": 3, "r": 9.4}, {"x": 12, "y": 3, "r": 10.0}, {"x": 13, "y": 3, "r": 4.1}, {"x": 14, "y": 3, "r": 9.1}, {"x": 15, "y": 3, "r": 10.8}, {"x": 16, "y": 3, "r": 10.7}, {"x": 19, "y": 3, "r": 8.4}, {"x": 0, "y": 5, "r": 5.3}, {"x": 16, "y": 0, "r": 3.6}, {"x": 17, "y": 0, "r": 3.2}, {"x": 18, "y": 2, "r": 10.3}, {"x": 17, "y": 3, "r": 10.7}, {"x": 23, "y": 3, "r": 6.4}, {"x": 0, "y": 4, "r": 6.4}, {"x": 1, "y": 4, "r": 5.8}, {"x": 6, "y": 5, "r": 2.8}, {"x": 10, "y": 6, "r": 2.5}, {"x": 17, "y": 6, "r": 4.3}, {"x": 23, "y": 0, "r": 4.2}, {"x": 10, "y": 1, "r": 5.4}, {"x": 20, "y": 1, "r": 6.3}, {"x": 22, "y": 2, "r": 6.5}, {"x": 20, "y": 3, "r": 6.3}, {"x": 21, "y": 3, "r": 6.1}, {"x": 22, "y": 3, "r": 6.4}, {"x": 14, "y": 6, "r": 3.6}, {"x": 15, "y": 6, "r": 3.2}, {"x": 16, "y": 6, "r": 3.8}, {"x": 18, "y": 6, "r": 4.6}, {"x": 20, "y": 6, "r": 4.8}, {"x": 21, "y": 6, "r": 4.8}, {"x": 23, "y": 6, "r": 5.1}, {"x": 0, "y": 0, "r": 4.9}, {"x": 10, "y": 0, "r": 2.5}, {"x": 12, "y": 0, "r": 3.1}, {"x": 19, "y": 0, "r": 3.4}, {"x": 0, "y": 1, "r": 5.2}, {"x": 22, "y": 4, "r": 5.2}, {"x": 23, "y": 4, "r": 5.4}, {"x": 22, "y": 5, "r": 4.2}, {"x": 0, "y": 6, "r": 4.0}, {"x": 1, "y": 6, "r": 3.6}, {"x": 2, "y": 6, "r": 3.5}, {"x": 3, "y": 6, "r": 3.1}, {"x": 19, "y": 6, "r": 4.9}, {"x": 22, "y": 6, "r": 4.9}, {"x": 1, "y": 0, "r": 4.3}, {"x": 2, "y": 0, "r": 3.6}, {"x": 3, "y": 0, "r": 3.7}, {"x": 11, "y": 0, "r": 2.9}, {"x": 14, "y": 0, "r": 4.4}, {"x": 15, "y": 0, "r": 4.2}, {"x": 13, "y": 1, "r": 4.8}, {"x": 1, "y": 5, "r": 5.7}, {"x": 22, "y": 0, "r": 3.5}, {"x": 1, "y": 1, "r": 5.7}, {"x": 20, "y": 4, "r": 6.0}, {"x": 2, "y": 5, "r": 4.8}, {"x": 3, "y": 5, "r": 4.7}, {"x": 4, "y": 5, "r": 3.6}, {"x": 5, "y": 5, "r": 3.8}, {"x": 12, "y": 6, "r": 3.2}, {"x": 20, "y": 5, "r": 5.0}, {"x": 11, "y": 6, "r": 2.4}, {"x": 13, "y": 0, "r": 3.8}, {"x": 2, "y": 1, "r": 5.1}, {"x": 3, "y": 1, "r": 4.1}, {"x": 9, "y": 1, "r": 2.9}, {"x": 10, "y": 2, "r": 5.6}, {"x": 2, "y": 4, "r": 5.5}, {"x": 10, "y": 4, "r": 5.6}, {"x": 4, "y": 6, "r": 2.9}, {"x": 21, "y": 2, "r": 5.4}, {"x": 18, "y": 0, "r": 3.8}, {"x": 3, "y": 4, "r": 4.9}, {"x": 13, "y": 4, "r": 4.9}, {"x": 13, "y": 5, "r": 3.9}, {"x": 8, "y": 2, "r": 2.0}, {"x": 2, "y": 2, "r": 6.0}, {"x": 3, "y": 2, "r": 5.2}, {"x": 13, "y": 2, "r": 4.7}, {"x": 5, "y": 3, "r": 2.5}, {"x": 6, "y": 3, "r": 2.2}, {"x": 7, "y": 3, "r": 1.4}, {"x": 8, "y": 3, "r": 2.8}, {"x": 8, "y": 0, "r": 1.4}, {"x": 9, "y": 0, "r": 1.9}, {"x": 9, "y": 2, "r": 3.1}, {"x": 8, "y": 4, "r": 2.0}, {"x": 8, "y": 6, "r": 1.7}, {"x": 4, "y": 0, "r": 3.5}, {"x": 4, "y": 4, "r": 4.1}, {"x": 5, "y": 4, "r": 3.3}, {"x": 9, "y": 4, "r": 2.5}, {"x": 8, "y": 5, "r": 2.5}, {"x": 6, "y": 2, "r": 2.4}, {"x": 7, "y": 2, "r": 1.9}, {"x": 5, "y": 6, "r": 2.2}, {"x": 6, "y": 6, "r": 2.2}, {"x": 7, "y": 6, "r": 2.4}, {"x": 5, "y": 0, "r": 2.9}, {"x": 4, "y": 1, "r": 3.6}, {"x": 6, "y": 0, "r": 1.4}, {"x": 7, "y": 1, "r": 1.4}, {"x": 8, "y": 1, "r": 1.4}, {"x": 4, "y": 2, "r": 3.5}, {"x": 6, "y": 4, "r": 2.4}, {"x": 7, "y": 4, "r": 2.0}, {"x": 7, "y": 5, "r": 2.6}, {"x": 5, "y": 1, "r": 2.8}, {"x": 9, "y": 6, "r": 1.7}, {"x": 5, "y": 2, "r": 2.4}, {"x": 6, "y": 1, "r": 2.0}],
          },
        ],
        labels: [...new Array(168)].map(_ => ""),
      },
      options: {
        ...bubbleOptions,
        plugins: { title: { padding: 25, text: "Work, 2018-2021" } },
      },
      type: "bubble",
    }
  );
});
</script>
