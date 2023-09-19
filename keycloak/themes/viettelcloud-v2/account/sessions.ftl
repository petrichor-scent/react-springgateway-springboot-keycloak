<#import "template.ftl" as layout>
<@layout.mainLayout active='sessions' bodyClass='sessions'; section>

    <div class="title-container">
        <img src="${url.resourcesPath}/img/icons/title.svg" alt="" height="56">
        <h2 class="content-title">${msg("sessionsHtmlTitle")}</h2>
    </div>


    <table class="table custom-table">
        <thead>
            <tr>
                <td style="padding-left: 24px;">${msg("ip")}</td>
                <td>${msg("started")}</td>
                <td>${msg("lastAccess")}</td>
                <td>${msg("expires")}</td>
                <td>${msg("application")}</td>
            </tr>
        </thead>

        <tbody>
        <#list sessions.sessions as session>
            <tr>
                <td class="session-ip" style="padding-left: 24px;">${session.ipAddress}</td>
                <td class="session-started">${session.started?string["yyyy-MM-dd HH:mm:ss"]}</td>
                <td class="session-last-access">${session.lastAccess?string["yyyy-MM-dd HH:mm:ss"]}</td>
                <td class="session-expires">${session.expires?string["yyyy-MM-dd HH:mm:ss"]}</td>
                <td class="session-clients">
                    <#list session.clients as client>
                        ${client}<br/>
                    </#list>
                </td>
            </tr>
        </#list>
        </tbody>
        <script>
            const formatDigits = (number) => ("0" + number.toString()).slice(-2);
            const formatDate = (date) => {
                return formatDigits(date.getDate()) + '/' + formatDigits(date.getMonth() + 1) + '/' + date.getFullYear() + ' ' + formatDigits(date.getHours()) + ':' + formatDigits(date.getMinutes()) + ':' + formatDigits(date.getSeconds());
            }
            const rows = document.querySelectorAll("tbody > tr");
            const sessions = [];
            for (let row of rows) {
                const ip = row.getElementsByClassName("session-ip")[0].innerText;
                const started = row.getElementsByClassName("session-started")[0].innerText;
                const lastAccess = row.getElementsByClassName("session-last-access")[0].innerText;
                const expires = row.getElementsByClassName("session-expires")[0].innerText;
                const clients = row.getElementsByClassName("session-clients")[0].innerText;
                sessions.push({
                    ip,
                    started: formatDate(new Date(started.split(" ").join("T") + "Z")),
                    lastAccess: formatDate(new Date(lastAccess.split(" ").join("T") + "Z")),
                    expires: formatDate(new Date(expires.split(" ").join("T") + "Z")),
                    clients: clients.slice(0, 20) + (clients.length > 20 ? "..." : ""),
                    realStarted: new Date(started.split(" ").join("T") + "Z")
                });
            }

            sessions.sort((x, y) => {
                const xStarted = new Date(x.realStarted);
                const yStarted = new Date(y.realStarted);
                if (xStarted < yStarted) return 1;
                if (xStarted > yStarted) return -1;
                return 0;
            });

            let i = 0;
            for (let row of rows) {
                row.getElementsByClassName("session-ip")[0].innerText = sessions[i].ip;
                row.getElementsByClassName("session-started")[0].innerText = sessions[i].started;
                row.getElementsByClassName("session-last-access")[0].innerText = sessions[i].lastAccess;
                row.getElementsByClassName("session-expires")[0].innerText = sessions[i].expires;
                row.getElementsByClassName("session-clients")[0].innerText = sessions[i].clients;
                i += 1;
            }
        </script>
    </table>

    <form action="${url.sessionsUrl}" method="post">
        <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
        <div class="form-group" style="display: flex; justify-content: center;">
            <button id="logout-all-sessions" class="account-button primary-button" style="width: 300px !important; margin-top: 8px;">${msg("doLogOutAllSessions")}</button>
        </div>
    </form>

</@layout.mainLayout>
