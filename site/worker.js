// Redirect plain http to https before serving assets; the zone-level
// "Always Use HTTPS" toggle lives outside this repo, this does not.
export default {
    fetch(request, env) {
        const url = new URL(request.url);
        if (url.protocol === "http:" || request.headers.get("x-forwarded-proto") === "http") {
            url.protocol = "https:";
            return Response.redirect(url.toString(), 301);
        }
        return env.ASSETS.fetch(request);
    },
};
